using System;
using System.Collections;
using System.Collections.Generic;
using Object = UnityEngine.Object;

namespace SYJFramework
{
    public class ResLoader
    {
        public T LoadSync<T>(string assetBundle, string assetName) where T : Object
        {
            return DoLoadSync<T>(assetName, assetBundle);
        }

        public T LoadSync<T>(string assetName) where T : Object
        {
            return DoLoadSync<T>(assetName);
        }

        public void LoadAsync<T>(string assetName, Action<T> onLoaded) where T : Object
        {
            DoLoadAsync(assetName, null, onLoaded);
        }

        public void LoadAsync<T>(string assetBundleName, string assetName, Action<T> onLoaded) where T : Object
        {
            DoLoadAsync(assetName, assetBundleName, onLoaded);
        }

        private T DoLoadSync<T>(string assetName, string assetBundle = null) where T : Object
        {
            var res = GetOrCreateRes(assetName, assetBundle);

            if (res.State == ResState.Waiting)
            {
                res.LoadSync();
            }
            else if (res.State == ResState.Loading)
            {
                throw new Exception(string.Format("请不要在异步加载资源 {0} 时，进行 {0} 的同步加载", res.Name));
            }

            if (res.State == ResState.Loaded)
            {
                return res.Asset as T;
            }

            throw new Exception(string.Format("资源 {0} 加载失败", res.Name));
        }

        private void DoLoadAsync<T>(string assetName, string assetBundleName, Action<T> onLoaded) where T : Object
        {
            var res = GetOrCreateRes(assetName, assetBundleName);

            Action<Res> onResLoaded = null;

            onResLoaded = loadedRes =>
            {
                onLoaded(loadedRes.Asset as T);
                res.UnRegisterLoadedEvent(onResLoaded);
            };

            if (res.State == ResState.Waiting)
            {
                res.RegisterLoadedEvent(onResLoaded);
                res.LoadAsync();
            }
            else if (res.State == ResState.Loading)
            {
                res.RegisterLoadedEvent(onResLoaded);
            }
            else if (res.State == ResState.Loaded)
            {
                onLoaded(res.Asset as T);
            }
        }

        public void ReleaseAll()
        {
            mResRecord.ForEach(loadedAsset => loadedAsset.Release());

            mResRecord.Clear();
        }


        #region private    
        private List<Res> mResRecord = new List<Res>();

        private Res GetOrCreateRes(string assetName, string assetBundleName = null)
        {
            // 查询当前的 资源记录
            var res = GetResFromRecord(assetName);

            if (res != null)
            {
                return res;
            }

            // 查询全局资源池
            res = GetFromResMgr(assetName);

            if (res != null)
            {
                AddRes2Record(res);

                return res;
            }
            else
            {
                res = CreateRes(assetName, assetBundleName);
            }

            return res;
        }

        private Res CreateRes(string assetName, string ownerBundle = null)
        {
            var res = ResFactory.Create(assetName, ownerBundle);

            GameEntry.Res.SharedLoadedReses.Add(res);

            AddRes2Record(res);

            return res;
        }


        private Res GetResFromRecord(string assetName)
        {
            return mResRecord.Find(loadedAsset => loadedAsset.Name == assetName);
        }

        private Res GetFromResMgr(string assetName)
        {
            return GameEntry.Res.SharedLoadedReses.Find(loadedAsset => loadedAsset.Name == assetName);
        }

        private void AddRes2Record(Res resFromResMgr)
        {
            mResRecord.Add(resFromResMgr);

            resFromResMgr.Retain();
        }


        #endregion
    }
}
using System;
using UnityEngine;

namespace SYJFramework
{
    public class ResourcesRes : Res
    {
        private string mPath;

        public ResourcesRes(string path)
        {
            Name = path;

            mPath = path.Substring("resources://".Length);

            State = ResState.Waiting;
        }

        public override bool LoadSync()
        {
            Asset = Resources.Load(mPath);

            State = ResState.Loaded;

            return Asset;
        }        

        public override void LoadAsync()
        {    
            Debug.Log("Resource LoadAsync");
            State = ResState.Loading;

            var request = Resources.LoadAsync(mPath);

            request.completed += operation =>
            {                
                Asset = request.asset;

                State = ResState.Loaded;                
            };
        }

        protected override void OnReleaseRes()
        {
            if (Asset != null)
            {
                if (Asset is GameObject)
                {

                }
                else
                {
                    Resources.UnloadAsset(Asset);
                }

                Asset = null;
            }

            GameEntry.Res.SharedLoadedReses.Remove(this);
        }
    }
}
using System;
using UnityEngine;

namespace SYJFramework
{
    public class AssetBundleRes : Res
    {
        private static AssetBundleManifest mManifest;
        public static AssetBundleManifest Manifest
        {
            get
            {
                if (!mManifest)
                {
                    var bundle = AssetBundle.LoadFromFile(ResKitUtil.FullPathForAssetBundle(ResKitUtil.GetPlatformName()));
                    mManifest = bundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
                }

                return mManifest;
            }
        }

        private string mPath;

        public AssetBundle AssetBundle
        {
            get { return Asset as AssetBundle; }
            private set { Asset = value; }
        }

        public AssetBundleRes(string assetBundleName)
        {
            mPath = ResKitUtil.FullPathForAssetBundle(assetBundleName);

            Name = assetBundleName;

            State = ResState.Waiting;
        }

        private ResLoader mResLoader = new ResLoader();

        public override bool LoadSync()
        {
            State = ResState.Loading;

            var dependencyBundleNames = ResData.Instance.GetDirectDependencies(Name);

            foreach (var dependencyBundleName in dependencyBundleNames)
            {
                mResLoader.LoadSync<AssetBundle>(dependencyBundleName);
            }

            if (!ResManager.IsSimulationModeLogic)
            {
                AssetBundle = AssetBundle.LoadFromFile(mPath);
            }

            State = ResState.Loaded;

            return AssetBundle;
        }

        private void LoadDependencyBundlesAsync(Action onAllLoaded)
        {
            var dependencyBundleNames = ResData.Instance.GetDirectDependencies(Name);

            var loadedCount = 0;

            if (dependencyBundleNames.Length == 0)
            {
                onAllLoaded();
            }

            foreach (var dependencyBundleName in dependencyBundleNames)
            {
                mResLoader.LoadAsync<AssetBundle>(dependencyBundleName,
                    dependBundle =>
                    {
                        loadedCount++;

                        if (loadedCount == dependencyBundleNames.Length)
                        {
                            onAllLoaded();
                        }
                    });
            }
        }

        public override void LoadAsync()
        {

            State = ResState.Loading;

            LoadDependencyBundlesAsync(() =>
            {
                if (ResManager.IsSimulationModeLogic)
                {
                    State = ResState.Loaded;
                }
                else
                {
                    var resRequest = AssetBundle.LoadFromFileAsync(mPath);

                    resRequest.completed += operation =>
                    {
                        AssetBundle = resRequest.assetBundle;

                        Asset = AssetBundle;

                        State = ResState.Loaded;
                    };
                }
            });
        }

        protected override void OnReleaseRes()
        {
            if (AssetBundle != null)
            {
                AssetBundle.Unload(true);
                AssetBundle = null;

                mResLoader.ReleaseAll();
                mResLoader = null;
            }

            GameEntry.Res.SharedLoadedReses.Remove(this);
        }
    }
}
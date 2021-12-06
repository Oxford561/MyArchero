  using System.Collections.Generic;

    namespace SYJFramework
    {
        public class AssetBundleData
        {
            public string Name;

            public List<AssetData> AssetDataList = new List<AssetData>();

            public string[] DependencyBundleNames;
        }
    }
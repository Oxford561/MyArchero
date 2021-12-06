using System.IO;
using UnityEditor;
using UnityEngine;

namespace SYJFramework
{
    public class AssetBundleExporter : MonoBehaviour
    {
        [MenuItem("SYJFramework/Framework/ResKit/Build AssetBundles")]
        static void BuildAssetBundles()
        {
            var outputPath = Application.streamingAssetsPath + "/AssetBundles/" + ResKitUtil.GetPlatformName();

            if (!Directory.Exists(outputPath))
            {
                Directory.CreateDirectory(outputPath);
            }

            BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.ChunkBasedCompression,
                EditorUserBuildSettings.activeBuildTarget);

            AssetDatabase.Refresh();
        }
    }
}
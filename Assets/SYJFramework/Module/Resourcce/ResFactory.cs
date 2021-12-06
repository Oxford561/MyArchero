namespace SYJFramework
{
    /// <summary>
    /// 资源工厂，加载各种资源的处理器
    /// </summary>
    public class ResFactory
    {
        public static Res Create(string assetName, string ownerBundle)
        {
            Res res = null;

            if (ownerBundle != null)
            {
                res = new AssetRes(assetName, ownerBundle);
            }
            else if (assetName.StartsWith("resources://"))
            {
                res = new ResourcesRes(assetName);
            }
            else
            {
                res = new AssetBundleRes(assetName);
            }

            return res;
        }
    }
}
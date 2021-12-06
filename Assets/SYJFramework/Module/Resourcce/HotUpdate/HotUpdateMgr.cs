namespace SYJFramework
{
    public class HotUpdateMgr : MonoSingleton<HotUpdateMgr>
    {
        private int GetRemoteResVersion()
        {
            return 1;
        }

        private int GetLocalResVersion()
        {
            return 0;
        }

        public bool HasNewVersionRes
        {
            get { return GetRemoteResVersion() > GetLocalResVersion(); }
        }
    }
}
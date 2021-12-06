using System;
using Object = UnityEngine.Object;

namespace SYJFramework
{
    public enum ResState
    {
        Waiting,
        Loading,
        Loaded
    }

    public abstract class Res : SimpleRC
    {
        public string Name { get; protected set; }

        public Object Asset { get; protected set; }

        public abstract bool LoadSync();

        public abstract void LoadAsync();

        protected abstract void OnReleaseRes();

        protected override void OnZeroRef()
        {
            OnReleaseRes();
        }

        private ResState mState;

        public ResState State
        {
            get { return mState; }
            protected set
            {
                mState = value;
                if (mState == ResState.Loaded)
                {
                    if (mLoadedEvent != null)
                    {
                        mLoadedEvent.Invoke(this);
                    }
                }
            }
        }

        protected event Action<Res> mLoadedEvent;

        public void RegisterLoadedEvent(Action<Res> onLoaded)
        {
            mLoadedEvent += onLoaded;
        }

        public void UnRegisterLoadedEvent(Action<Res> onLoaded)
        {
            mLoadedEvent -= onLoaded;
        }
    }
}
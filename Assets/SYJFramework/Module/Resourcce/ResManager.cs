using System.Collections.Generic;
using UnityEngine;

namespace SYJFramework
{
    public class ResManager
    {
        private ResLoader loader;

        public ResLoader Loader
        {
            get
            {
                if (loader == null)
                {
                    loader = new ResLoader();
                }
                return loader;
            }
            
            set
            {
                loader = value;
            }
        }

        public static bool IsSimulationModeLogic
        {
            get
            {
#if UNITY_EDITOR
                return SimulationMode;
#endif
                return false;
            }
        }


#if UNITY_EDITOR
        private const string kSimulationMode = "simulation mode";

        private static int mSimulationMode = -1;
        public static bool SimulationMode
        {
            get
            {
                if (mSimulationMode == -1)
                {
                    mSimulationMode = UnityEditor.EditorPrefs.GetInt(kSimulationMode, 1);
                }

                return mSimulationMode != 0;
            }
            set
            {
                mSimulationMode = value ? 1 : 0;
                UnityEditor.EditorPrefs.SetInt(kSimulationMode, mSimulationMode);
            }
        }
#endif

        public List<Res> SharedLoadedReses = new List<Res>();

#if UNITY_EDITOR
        private void OnGUI()
        {
            if (Input.GetKey(KeyCode.F1))
            {
                GUILayout.BeginVertical("box");

                SharedLoadedReses.ForEach(loadedRes =>
                {
                    GUILayout.Label(string.Format("Name:{0} RefCount:{1} State:{2}", loadedRes.Name, loadedRes.RefCount, loadedRes.State));
                });

                GUILayout.EndVertical();
            }
        }
#endif
    }
}
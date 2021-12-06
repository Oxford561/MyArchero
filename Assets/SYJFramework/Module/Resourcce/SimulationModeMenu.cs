

namespace SYJFramework
{
    public class SimulationModeMenu
    {
        #if UNITY_EDITOR
        private const string kSimulationModeKey = "simulation mode";
        private const string kSimulationModePath = "SYJFramework/Framework/ResKit/Simulation Mode";

        [UnityEditor.MenuItem(kSimulationModePath)]
        private static void ToggleSimulationMode()
        {
            ResManager.SimulationMode = !ResManager.SimulationMode;
        }

        [UnityEditor.MenuItem(kSimulationModePath, true)]
        public static bool ToggleSimulationModeValidate()
        {
            UnityEditor.Menu.SetChecked(kSimulationModePath, ResManager.SimulationMode);
            return true;
        }
        #endif
    }
}
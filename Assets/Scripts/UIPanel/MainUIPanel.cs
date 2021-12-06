using System.Collections;
using System.Collections.Generic;
using SYJFramework;
using UnityEngine;

public class MainUIPanel : UIPanel
{
    protected override void OnOpen(IUIData data = null)
    {
        // 播放主界面的背景音乐
        GameEntry.Audio.Play("Res/Sound/Bg/uibg.wav");
    }
}

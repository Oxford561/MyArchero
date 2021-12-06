using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SYJFramework;
using UnityEngine.UI;

public class LanguageSelectPanel : UIPanel
{
    [SerializeField]
    private Button closeBtn;
    
    protected override void OnOpen(IUIData data = null)
    {
        closeBtn.onClick.AddListener(()=>{GameEntry.UI.CloseSelf(this);});
    }
}

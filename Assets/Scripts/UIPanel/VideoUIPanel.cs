/*******************************************************************
* Copyright(c) #YEAR# #COMPANY#
* All rights reserved.
*
* 文件名称: #SCRIPTFULLNAME#
* 简要描述:
* 
* 创建日期: #DATE#
* 作者:     #AUTHOR#
* 说明:  
******************************************************************/
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SYJFramework;
using UnityEngine.UI;
using DG.Tweening;

public class VideoUIPanel : UIPanel
{
    [SerializeField]
    private Image imageBoss;
    [SerializeField]
    private Image imageHero;
    [SerializeField]
    private Text text1;
    [SerializeField]
    private Text text2;

    protected override void OnOpen(IUIData data = null)
    {
        // 过长动画制作
        var sequeue = DOTween.Sequence();

        sequeue.AppendInterval(1f);

        //首先 boss fade 出现 然后 text1 出现
        sequeue.Append(imageBoss.GetComponent<CanvasGroup>().DOFade(1, 1)).AppendCallback(() =>
        {
            sequeue.Append(text1.GetComponent<CanvasGroup>().DOFade(1, 0.5f));
            // 添加 魔王的笑声
            GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Cg/cg_boss_laugh.wav",Vector3.zero,false);
        });
        sequeue.AppendInterval(1f);

        //间隔一小段时间  text1 消失
        sequeue.AppendInterval(0.6f).AppendCallback(() => { text1.gameObject.SetActive(false); });
        //hero 透明出现，上升
        sequeue.Append(imageHero.GetComponent<CanvasGroup>().DOFade(1, 0.2f));
        sequeue.Append(imageHero.transform.DOMoveY(-30, 1f)).AppendCallback(() =>
        {
            sequeue.Append(text2.GetComponent<CanvasGroup>().DOFade(1, 0.5f));
        });

        sequeue.AppendInterval(1f);

        sequeue.AppendCallback(() =>
        {
            GameEntry.UI.CloseSelf(this);
            GameEntry.UI.OpenUI("MainUIPanel");
        });
    }

}
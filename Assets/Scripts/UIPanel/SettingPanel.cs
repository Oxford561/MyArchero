using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using SYJFramework;

public class SettingPanel : MonoBehaviour
{
    [SerializeField]
    private Button musicBtn;
    [SerializeField]
    private Button soundBtn;
    [SerializeField]
    private Button languageBtn;
    [SerializeField]
    private Button qualityBtn;

    [SerializeField]
    private Sprite redSprite;
    [SerializeField]
    private Sprite greenSprite;
    [SerializeField]
    private Sprite blueSprite;

    private bool isOpenMusic = true;
    private bool isOpenSound = true;
    private string selectLanguage = string.Empty;
    private bool isNormalQuality = false;

    void Start()
    {
        SetButtonEvent();
        selectLanguage = "简体中文";
        TimeAction ta = GameEntry.Time.CreateTimeAction();
        ta.Init(.5f, 5f, 1, () =>
       {
           InitConfig();
       }, null, null).Run();
    }

    void InitConfig()
    {
        // 读取缓存文件设置
        if (PlayerPrefs.HasKey("Music"))
        {
            bool isMusic = PlayerPrefs.GetInt("Music") == 1;
            isOpenMusic = isMusic;

            if (isMusic)
            {
                musicBtn.transform.GetComponentInChildren<Text>().text = "开启";
                musicBtn.transform.GetComponent<Image>().sprite = greenSprite;
            }
            else
            {
                musicBtn.transform.GetComponentInChildren<Text>().text = "关闭";
                musicBtn.transform.GetComponent<Image>().sprite = redSprite;
            }
        }

        if (PlayerPrefs.HasKey("Sound"))
        {
            bool isSound = PlayerPrefs.GetInt("Sound") == 1;
            isOpenSound = isSound;
            if (isSound)
            {
                soundBtn.transform.GetComponentInChildren<Text>().text = "开启";
                soundBtn.transform.GetComponent<Image>().sprite = greenSprite;
            }
            else
            {
                soundBtn.transform.GetComponentInChildren<Text>().text = "关闭";
                soundBtn.transform.GetComponent<Image>().sprite = redSprite;
            }
        }

    }

    private void SetButtonEvent()
    {
        musicBtn.onClick.AddListener(OnMusicBtnEvent);
        soundBtn.onClick.AddListener(OnSoundBtnEvent);
        languageBtn.onClick.AddListener(OnLanguageBtnEvent);
        qualityBtn.onClick.AddListener(OnQualityBtnEvent);
    }

    private void OnMusicBtnEvent()
    {
        isOpenMusic = !isOpenMusic;
        // 无论关闭音乐都触发点击按钮效果
        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_Click_Small.wav", Vector3.zero);
        musicBtn.transform.DOShakeScale(0.2f, 0.3f).OnComplete(() =>
         {
             musicBtn.transform.localScale = Vector3.one;
             if (isOpenMusic)
             {
                 // 打开背景音乐声量
                 GameEntry.Audio.StartBg();
                 PlayerPrefs.SetInt("Music", 1);
                 musicBtn.transform.GetComponentInChildren<Text>().text = "开启";
                 musicBtn.transform.GetComponent<Image>().sprite = greenSprite;
             }
             else
             {
                 // 关闭背景音乐声量
                 GameEntry.Audio.StopBg();
                 PlayerPrefs.SetInt("Music", 0);
                 musicBtn.transform.GetComponentInChildren<Text>().text = "关闭";
                 musicBtn.transform.GetComponent<Image>().sprite = redSprite;
             }
         });
    }

    private void OnSoundBtnEvent()
    {
        // 无论关闭音效都触发点击按钮效果
        isOpenSound = !isOpenSound;
        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_Click_Small.wav", Vector3.zero);
        soundBtn.transform.DOShakeScale(0.2f, 0.3f).OnComplete(() =>
         {
             soundBtn.transform.localScale = Vector3.one;
             if (isOpenSound)
             {
                 // 打开音效
                 GameEntry.Audio.StartSound();
                 PlayerPrefs.SetInt("Sound", 1);
                 soundBtn.transform.GetComponentInChildren<Text>().text = "开启";
                 soundBtn.transform.GetComponent<Image>().sprite = greenSprite;
             }
             else
             {
                 // 关闭音效
                 GameEntry.Audio.StopSound();
                 PlayerPrefs.SetInt("Sound", 0);
                 soundBtn.transform.GetComponentInChildren<Text>().text = "关闭";
                 soundBtn.transform.GetComponent<Image>().sprite = redSprite;
             }
         });
    }

    private void OnLanguageBtnEvent()
    {
        // 无论选择什么语言都触发点击按钮效果
        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_Click_Small.wav", Vector3.zero);
        languageBtn.transform.DOShakeScale(0.2f, 0.3f).OnComplete(() =>
         {
             languageBtn.transform.localScale = Vector3.one;
             // 弹窗进行选择
             GameEntry.UI.OpenUI("LanguageSelectPanel", UILevel.Pop);
         });
    }

    private void OnQualityBtnEvent()
    {
        // 无论选择什么画面质量都触发点击按钮效果
        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_Click_Small.wav", Vector3.zero);
        isNormalQuality = !isNormalQuality;
        qualityBtn.transform.DOShakeScale(0.2f, 0.3f).OnComplete(() =>
         {
             qualityBtn.transform.localScale = Vector3.one;
             if (isNormalQuality)
             {
                 qualityBtn.transform.GetComponentInChildren<Text>().text = "中";
             }
             else
             {
                 qualityBtn.transform.GetComponentInChildren<Text>().text = "高";
             }
         });
    }

}

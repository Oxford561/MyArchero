using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using SYJFramework;

public class TabMenuPanel : MonoBehaviour
{
    [SerializeField]
    private ScrollPage scrollPage;
    [SerializeField]
    private RectTransform moveBg;
    private float currMoveBgX = 0;
    private bool isMove = false;
    private Vector2 currPos = Vector2.zero; // 默认中间位置
    private Vector2 targetPos = Vector2.zero;

    [SerializeField]
    private Button shopBtn;
    [SerializeField]
    private Button equipmentBtn;
    [SerializeField]
    private Button worldBtn;
    [SerializeField]
    private Button talentBtn;
    [SerializeField]
    private Button settingBtn;

    private RectTransform shopRect;
    private RectTransform equipmentRect;
    private RectTransform worldRect;
    private RectTransform talentRect;
    private RectTransform settingRect;

    private Vector2 shopInit;
    private Vector2 equipmentInit;
    private Vector2 worldInit;
    private Vector2 talentInit;
    private Vector2 settingInit;

    private float smooth = 10;

    void Start()
    {
        shopBtn.onClick.AddListener(OnShopBtnClickByShake);
        equipmentBtn.onClick.AddListener(OnEquipmentBtnClickByShake);
        worldBtn.onClick.AddListener(OnWorldBtnClickByShake);
        talentBtn.onClick.AddListener(OnTalentBtnClickByShake);
        settingBtn.onClick.AddListener(OnSettingBtnClickByShake);

        shopRect = shopBtn.GetComponent<RectTransform>();
        equipmentRect = equipmentBtn.GetComponent<RectTransform>();
        worldRect = worldBtn.GetComponent<RectTransform>();
        talentRect = talentBtn.GetComponent<RectTransform>();
        settingRect = settingBtn.GetComponent<RectTransform>();

        shopInit = new Vector2(shopRect.sizeDelta.x, shopRect.sizeDelta.y);
        equipmentInit = new Vector2(equipmentRect.sizeDelta.x, equipmentRect.sizeDelta.y);
        worldInit = new Vector2(worldRect.sizeDelta.x, worldRect.sizeDelta.y);
        talentInit = new Vector2(talentRect.sizeDelta.x, talentRect.sizeDelta.y);
        settingInit = new Vector2(settingRect.sizeDelta.x, settingRect.sizeDelta.y);

        scrollPage.BindEvent(OnPageChange, OnPageDrag, OnPageDragEnd);

        worldRect.sizeDelta = new Vector2(worldRect.sizeDelta.x * 2, worldRect.sizeDelta.y);

        // 默认打开世界地图界面
        GameEntry.Time.CreateTimeAction().Init(.5f, 1, 0, () =>
        {
            WorldBtnClick(true);
        }).Run();
    }

    private void OnPageChange(int pageCount, int pageIndex)
    {
        switch (pageIndex)
        {
            case 0:
                ShopBtnClick(true);
                break;
            case 1:
                EquipmentBtnClick(true);
                break;
            case 2:
                WorldBtnClick(true);
                break;
            case 3:
                TalentBtnClick(true);
                break;
            case 4:
                SettingBtnClick(true);
                break;
        }
    }

    private void OnPageDrag(float offsetX)
    {
        moveBg.anchoredPosition = new Vector2(currMoveBgX - (offsetX * 0.33333333f) / 2, moveBg.anchoredPosition.y);
    }

    private void OnPageDragEnd(float offsetX)
    {
        if (Mathf.Abs(offsetX) < 360)
        {
            targetPos = new Vector2(currMoveBgX, moveBg.anchoredPosition.y);
            isMove = true;
        }
    }

    private void SetBtnDefaultStatus()
    {
        shopRect.sizeDelta = shopInit;
        equipmentRect.sizeDelta = equipmentInit;
        worldRect.sizeDelta = worldInit;
        talentRect.sizeDelta = talentInit;
        settingRect.sizeDelta = settingInit;
        shopRect.anchoredPosition = new Vector2(-300, 70);
        equipmentRect.anchoredPosition = new Vector2(-180, 70);
        worldRect.anchoredPosition = new Vector2(0, 70);
        talentRect.anchoredPosition = new Vector2(180, 70);
        settingRect.anchoredPosition = new Vector2(300, 70);

        shopBtn.transform.Find("Text").gameObject.SetActive(false);
        shopBtn.transform.Find("Image").localScale = Vector3.one;
        shopBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
        equipmentBtn.transform.Find("Text").gameObject.SetActive(false);
        equipmentBtn.transform.Find("Image").localScale = Vector3.one;
        equipmentBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
        worldBtn.transform.Find("Text").gameObject.SetActive(false);
        worldBtn.transform.Find("Image").localScale = Vector3.one;
        worldBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
        talentBtn.transform.Find("Text").gameObject.SetActive(false);
        talentBtn.transform.Find("Image").localScale = Vector3.one;
        talentBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
        settingBtn.transform.Find("Text").gameObject.SetActive(false);
        settingBtn.transform.Find("Image").localScale = Vector3.one;
        settingBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
    }

    private void Update()
    {
        if (isMove)
        {
            moveBg.anchoredPosition = Vector2.Lerp(moveBg.anchoredPosition, targetPos, Time.deltaTime * smooth);
            if (Vector2.Distance(moveBg.anchoredPosition, targetPos) < 0.01f)
            {
                currPos = targetPos;
                isMove = false;
            }
        }
    }


    #region tab 按钮点击事件

    void ShopBtnClick(bool isScroll = false)
    {
        if (isScroll)
        {
            OnShopBtnClickByNoShake();
        }
        else
        {
            OnShopBtnClickByShake();
        }
    }

    void OnShopBtnClickByShake()
    {
        shopBtn.transform.DOShakeScale(0.2f, 0.5f).OnComplete(() =>
         {
             OnShopBtnClickByNoShake();
         });
    }

    void OnShopBtnClickByNoShake()
    {
        SetBtnDefaultStatus();

        shopBtn.transform.localScale = Vector3.one;
        // 按钮变宽一倍
        shopRect.sizeDelta = new Vector2(shopRect.sizeDelta.x * 2, shopRect.sizeDelta.y);
        isMove = true;
        targetPos = new Vector2(-240, 0);
        shopBtn.transform.Find("Text").gameObject.SetActive(true);
        shopBtn.transform.Find("Image").localScale = new Vector3(1.2f, 1.2f, 1);
        shopRect.anchoredPosition = new Vector2(-240, 70);
        worldRect.anchoredPosition = new Vector2(60, 70);
        equipmentRect.anchoredPosition = new Vector2(-60, 70);

        shopBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = new Vector2(0, 30);


        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_MainPageTurn.wav", Vector3.zero);
        scrollPage.TabClick(0, 0);
        currMoveBgX = -240;
    }

    void EquipmentBtnClick(bool isScroll = false)
    {
        if (isScroll)
        {
            OnEquipmentBtnClickNoShake();
        }
        else
        {
            OnEquipmentBtnClickByShake();
        }
    }

    void OnEquipmentBtnClickByShake()
    {
        equipmentBtn.transform.DOShakeScale(0.2f, 0.5f).OnComplete(() =>
         {
             OnEquipmentBtnClickNoShake();
         });
    }

    void OnEquipmentBtnClickNoShake()
    {
        SetBtnDefaultStatus();

        equipmentBtn.transform.localScale = Vector3.one;

        // 按钮变宽一倍
        equipmentRect.sizeDelta = new Vector2(equipmentRect.sizeDelta.x * 2, equipmentRect.sizeDelta.y);
        isMove = true;
        targetPos = new Vector2(-120, 0);
        equipmentBtn.transform.Find("Text").gameObject.SetActive(true);
        equipmentBtn.transform.Find("Image").localScale = new Vector3(1.2f, 1.2f, 1);
        equipmentRect.anchoredPosition = new Vector2(-120, 70);
        worldRect.anchoredPosition = new Vector2(60, 70);

        equipmentBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = new Vector2(0, 30);

        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_MainPageTurn.wav", Vector3.zero);
        scrollPage.TabClick(0.25f, 1);
        currMoveBgX = -120;
    }

    void WorldBtnClick(bool isScroll = false)
    {
        if (isScroll)
        {
            OnWorldBtnClickNoShake();
        }
        else
        {
            OnWorldBtnClickByShake();
        }
    }

    void OnWorldBtnClickByShake()
    {
        worldBtn.transform.DOShakeScale(0.2f, 0.5f).OnComplete(() =>
        {
            OnWorldBtnClickNoShake();
        });
    }

    void OnWorldBtnClickNoShake()
    {
        SetBtnDefaultStatus();

        worldBtn.transform.localScale = Vector3.one;
        // 按钮变宽一倍
        worldRect.sizeDelta = new Vector2(worldRect.sizeDelta.x * 2, worldRect.sizeDelta.y);
        isMove = true;
        targetPos = Vector2.zero;
        worldBtn.transform.Find("Text").gameObject.SetActive(true);
        worldBtn.transform.Find("Image").localScale = new Vector3(1.2f, 1.2f, 1);

        worldBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = new Vector2(0, 30);


        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_MainPageTurn.wav", Vector3.zero);
        scrollPage.TabClick(0.5f, 2);
        currMoveBgX = 0;
    }

    void TalentBtnClick(bool isScroll)
    {
        if (isScroll)
        {
            OnTalentBtnClickNoShake();
        }
        else
        {
            OnTalentBtnClickByShake();
        }
    }


    void OnTalentBtnClickByShake()
    {
        talentBtn.transform.DOShakeScale(0.2f, 0.5f).OnComplete(() =>
        {
            OnTalentBtnClickNoShake();
        });
    }

    void OnTalentBtnClickNoShake()
    {
        SetBtnDefaultStatus();

        talentBtn.transform.localScale = Vector3.one;
        // 按钮变宽一倍
        talentRect.sizeDelta = new Vector2(talentRect.sizeDelta.x * 2, talentRect.sizeDelta.y);
        isMove = true;
        targetPos = new Vector2(120, 0);
        talentBtn.transform.Find("Text").gameObject.SetActive(true);
        talentBtn.transform.Find("Image").localScale = new Vector3(1.2f, 1.2f, 1);
        talentRect.anchoredPosition = new Vector2(120, 70);
        worldRect.anchoredPosition = new Vector2(-60, 70);

        talentBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = new Vector2(0, 30);

        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_MainPageTurn.wav", Vector3.zero);
        scrollPage.TabClick(0.75f, 3);
        currMoveBgX = 120;
    }

    void SettingBtnClick(bool isScroll)
    {
        if (isScroll)
        {
            OnSettingBtnClickNoShake();
        }
        else
        {
            OnSettingBtnClickByShake();
        }
    }

    void OnSettingBtnClickByShake()
    {
        settingBtn.transform.DOShakeScale(0.2f, 0.5f).OnComplete(() =>
        {
            OnSettingBtnClickNoShake();
        });
    }

    void OnSettingBtnClickNoShake()
    {
        SetBtnDefaultStatus();

        settingBtn.transform.localScale = Vector3.one;
        // 按钮变宽一倍
        settingRect.sizeDelta = new Vector2(settingRect.sizeDelta.x * 2, settingRect.sizeDelta.y);
        isMove = true;
        targetPos = new Vector2(240, 0);
        settingBtn.transform.Find("Text").gameObject.SetActive(true);
        settingBtn.transform.Find("Image").localScale = new Vector3(1.2f, 1.2f, 1);
        settingRect.anchoredPosition = new Vector2(240, 70);
        worldRect.anchoredPosition = new Vector2(-60, 70);
        talentRect.anchoredPosition = new Vector2(60, 70);

        settingBtn.transform.Find("Image").GetComponent<RectTransform>().anchoredPosition = new Vector2(0, 30);

        GameEntry.Audio.PlayUIAudioEffect("Res/Sound/Main/Button_MainPageTurn.wav", Vector3.zero);
        scrollPage.TabClick(1, 4);
        currMoveBgX = 240;
    }

    #endregion

    private void OnDestroy()
    {
        scrollPage.ClearEvent(OnPageChange, OnPageDrag, OnPageDragEnd);
    }
}

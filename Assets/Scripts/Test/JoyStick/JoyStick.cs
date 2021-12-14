using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using System;

public class JoyStick : MonoBehaviour, IDragHandler, IPointerDownHandler, IPointerUpHandler, IEventSystemHandler
{
    #region 委托事件
    // 开始滑动委托声明
    public delegate void JoyTouchStart(JoyData data);
    // 滑动过程中的委托声明
    public delegate void JoyTouching(JoyData data);
    // 滑动停止的委托声明
    public delegate void JoyTouchEnd(JoyData data);
    // 提供外界事件
    public static event JoyTouchStart On_JoyTouchStart;
    // 提供外界事件
    public static event JoyTouching On_JoyTouching;
    // 提供外界事件
    public static event JoyTouchEnd On_JoyTouchEnd;
    #endregion

    #region 参数
    private JoyData m_Data = default(JoyData);
    // 记录当前摇杆是否激活
    private bool disable = false;
    private Transform child;
    private Transform touch;
    private Transform direction;
    // 摇杆的初始位置
    private Vector3 startPos;
    // 摇杆的半径(外面大的 背景到中心)
    private float mRadius;
    // 摇杆白点外围到背景外围的距离
    private float mRadiusSmall;
    // 记录触碰的id
    private int mTouchID = -1;

    // 视口坐标
    private Vector3 pos_v;
    private float pos_w;// 当下分辨率下 摇杆的宽度
    private Vector3 pos_2 = new Vector3(0.5f, 0.5f, 0f);// 偏移量
    private Vector2 Origin;// 初始化按下坐标

    [SerializeField]
    private Camera mCam;

    #endregion


    private void OnEnable()
    {
        disable = false;
    }

    private void OnDisable()
    {
        OnPointerUp(null);// 摇杆失效时 默认抬起
        disable = true;
    }

    private void Awake()
    {
        // 查找需要的组件
        child = transform.Find("Bg");
        direction = child.Find("BgParent/Direction");
        touch = child.Find("Touch");
        mCam = Camera.main;
        //找到 摇杆默认位置
        startPos = child.localPosition;
        // 得到摇杆的半径
        Vector2 sizeDelta = (child as RectTransform).sizeDelta;
        mRadius = sizeDelta.x * 0.5f;
        // 得到 中间圆形的半径
        Vector2 sizeDelta2 = (touch as RectTransform).sizeDelta;
        // 得到 中间圆形到外围的距离限制
        mRadiusSmall = mRadius - sizeDelta2.x * 0.5f;
        // JoyData 设置
        m_Data.direction = default(Vector3);
        direction.gameObject.SetActive(false);
    }

    private Vector3 GetPos(Vector3 pos)
    {
        // 屏幕坐标转换成视口坐标
        pos_v = mCam.ScreenToViewportPoint(pos) - pos_2;// 视口坐标（0-1）范围
        // 适应分辨率
        pos_w = (1280 / Screen.height) * (float)Screen.width;
        return new Vector3(pos_w * pos_v.x, 1280 * pos_v.y, 0f);
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        // 找到触碰的id，-1，-2，-3 鼠标左键，右键和中键
        mTouchID = eventData.pointerId;
        // eventData.position 这个是一个屏幕坐标，左下角(0,0)，右上角(屏幕宽，屏幕高)
        OnPointerDown(GetPos(eventData.position));
    }

    private void OnPointerDown(Vector3 pos)
    {
        if (disable)
        {
            return;
        }
        direction.gameObject.SetActive(true);
        child.localPosition = pos;
        Origin = pos;
        if (JoyStick.On_JoyTouchStart != null)
        {
            JoyStick.On_JoyTouchStart(m_Data);
        }
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        if (eventData != null && !disable && mTouchID == eventData.pointerId)
        {
            direction.gameObject.SetActive(false);
            touch.localPosition = Vector2.zero;
            // 回到初始位置
            if ((bool)child)
            {
                child.localPosition = startPos;
                direction.localRotation = Quaternion.identity;
            }

            if (JoyStick.On_JoyTouchEnd != null)
            {
                JoyStick.On_JoyTouchEnd(m_Data);
            }
        }
    }

    public void OnDrag(PointerEventData eventData)
    {
        if (disable || mTouchID != eventData.pointerId)
        {
            return;
        }
        DealDrag(GetPos(eventData.position));
        if (JoyStick.On_JoyTouching != null)
        {
            JoyStick.On_JoyTouching(m_Data);
        }
    }


    private Vector2 DealDrag_touchpos;

    // 处理 JoyData 的封装
    private void DealDrag(Vector2 pos, bool updateui = true)
    {
        // 超出摇杆半径则拉回来
        DealDrag_touchpos = pos - Origin;
        if (DealDrag_touchpos.magnitude > mRadiusSmall)
        {
            DealDrag_touchpos = DealDrag_touchpos.normalized * mRadiusSmall;
        }

        m_Data.direction = DealDrag_touchpos.normalized;
        // m_Data.length = DealDrag_touchpos.magnitude;
        m_Data.angle = 90 - Mathf.Atan2(m_Data.direction.normalized.y, m_Data.direction.normalized.x) * Mathf.Rad2Deg;
        // 更新 UI
        if (updateui)
        {
            touch.localPosition = DealDrag_touchpos;
            direction.localRotation = Quaternion.Euler(0f, 0f, 0f - m_Data.angle);
        }
    }

}

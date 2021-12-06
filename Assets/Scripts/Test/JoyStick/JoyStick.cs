using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class JoyStick : MonoBehaviour, IDragHandler, IPointerDownHandler, IPointerUpHandler, IEventSystemHandler
{
    [SerializeField]
    private Transform bgTrans;
    [SerializeField]
    private Transform directionTrans;

    [SerializeField]
    private Transform pointTransform;

    private int mTouchID = -1; //拖动的物体id
    private Vector2 origin;//原始位置
    private Vector2 touchPos; // 真正拖动的位置
    private float mRadius = 10;
    private bool touchdown = false;//是否点击

    void Start()
    {
        mRadius = (bgTrans as RectTransform).sizeDelta.x * 0.5f - (pointTransform as RectTransform).sizeDelta.x * 0.25f;
    }

    public void OnDrag(PointerEventData eventData)
    {
        Debug.Log("OnDrag");
        if (mTouchID != eventData.pointerId)
        {
            return;
        }

        if (!touchdown)
        {
            touchdown = true;
        }
        HandleDrag(eventData.position);
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        Debug.Log("OnPointerDown");
        mTouchID = eventData.pointerId;
        origin = eventData.position;
        touchdown = true;
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        Debug.Log("OnPointerUp");
        if (eventData != null && mTouchID == eventData.pointerId)
        {
            touchdown = false;
            directionTrans.localRotation = Quaternion.identity;
            pointTransform.localPosition = Vector3.zero;
        }
    }

    // 处理滑动
    private void HandleDrag(Vector2 pos)
    {
        Debug.Log("HandleDrag");
        touchPos = pos - origin;
        if (touchPos.magnitude > mRadius)
        {
            touchPos = touchPos.normalized * mRadius;
        }
        Vector2 normalized = touchPos.normalized;
        pointTransform.localPosition = touchPos;
        // directionTrans.localRotation = Quaternion.Euler(0f, 0f, 0f - m_Data.angle);
    }
}

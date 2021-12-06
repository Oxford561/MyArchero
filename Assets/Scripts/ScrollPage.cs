using UnityEngine;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using System;

public enum ScrollDirection
{
    Horizontal,
    Vertical
}

public class ScrollPage : MonoBehaviour, IBeginDragHandler, IEndDragHandler, IDragHandler
{
    public ScrollDirection SelectScrollDic = ScrollDirection.Horizontal;
    ScrollRect rect;
    List<float> pages = new List<float>();
    int currentPageIndex = 0; // 默认为0 时，去除第一次滑动到首页的触发

    //滑动速度
    [HideInInspector]
    public float smooting = 10;

    //滑动的起始坐标
    float targetHOrV = 0;

    //是否拖拽结束
    bool isDrag = false;

    /// <summary>
    /// 用于返回一个页码，-1说明page的数据为0
    /// </summary>
    public System.Action<int, int> OnPageChanged;

    public Action<float> OnPageDrag;

    public Action<float> OnPageDragEnd;

    float startime = 0f;
    float delay = 0.1f;
    public float scrollHorizontalPercentLeft = 0.7f;
    public float scrollHorizontalPercentRight = 1.3f;
    public float scrollVerticallPercentTop = 0.2f;
    public float scrollVerticallPercentBottom = 0.2f;
    private float lastPosX;
    private float lastPosY;

    void Awake()
    {
        rect = transform.GetComponent<ScrollRect>();
        startime = Time.time;
        lastPosX = 0;
        lastPosY = 0;
    }

    public void BindEvent(Action<int, int> pageChange, Action<float> pageDrag, Action<float> pageDragEnd)
    {
        OnPageChanged += pageChange;
        OnPageDrag += pageDrag;
        OnPageDragEnd += pageDragEnd;
    }

    public void ClearEvent(Action<int, int> pageChange, Action<float> pageDrag, Action<float> pageDragEnd)
    {
        OnPageChanged -= pageChange;
        OnPageDrag -= pageDrag;
        OnPageDragEnd -= pageDragEnd;
    }

    public void TabClick(float target, int curIndex)
    {
        targetHOrV = target;
        //rect.horizontalNormalizedPosition = targetHOrV;// 注释以后就不会立马过渡到当前页面了
        currentPageIndex = curIndex;
    }

    void Update()
    {
        if (Time.time < startime + delay) return;
        UpdatePages();

        //如果不判断。当在拖拽的时候要也会执行插值，所以会出现闪烁的效果
        //这里只要在拖动结束的时候。在进行插值
        if (!isDrag && pages.Count > 0)
        {
            if (SelectScrollDic == ScrollDirection.Horizontal)
            {
                rect.horizontalNormalizedPosition = Mathf.Lerp(rect.horizontalNormalizedPosition, targetHOrV, Time.deltaTime * smooting);
            }
            else
            {
                rect.verticalNormalizedPosition = Mathf.Lerp(rect.verticalNormalizedPosition, targetHOrV, Time.deltaTime * smooting);
            }

        }
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        isDrag = true;
        lastPosX = eventData.position.x;
        lastPosY = eventData.position.y;
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        isDrag = false;
        int index = 0;

        if (SelectScrollDic == ScrollDirection.Horizontal)
        {
            float posX = 0;
            // 用于优化滑动不顺畅的问题，不过水平方向就不需要了
            if (eventData != null && lastPosX > eventData.position.x)
            {
                //向右边
                posX = rect.horizontalNormalizedPosition * scrollHorizontalPercentRight;
            }
            else
            {
                //向左边
                posX = rect.horizontalNormalizedPosition * scrollHorizontalPercentLeft;
            }
            // posX = rect.horizontalNormalizedPosition;
            //假设离第一位最近
            float offset = Mathf.Abs(pages[index] - posX);
            for (int i = 1; i < pages.Count; i++)
            {
                float temp = Mathf.Abs(pages[i] - posX);
                if (temp < offset)
                {
                    index = i;

                    //保存当前的偏移量
                    //如果到最后一页。反翻页。所以要保存该值，如果不保存。你试试效果就知道
                    offset = temp;
                }
            }
        }
        else
        {
            float posY = 0;
            if (eventData != null && lastPosY > eventData.position.y)
            {
                // 向下
                posY = rect.verticalNormalizedPosition * scrollVerticallPercentTop;
            }
            else
            {
                // 向上
                posY = rect.verticalNormalizedPosition * scrollVerticallPercentBottom;
            }
            //假设离第一位最近
            float offset = Mathf.Abs(pages[index] - posY);
            for (int i = 1; i < pages.Count; i++)
            {
                float temp = Mathf.Abs(pages[i] - posY);
                if (temp < offset)
                {
                    index = i;

                    //保存当前的偏移量
                    //如果到最后一页。反翻页。所以要保存该值，如果不保存。你试试效果就知道
                    offset = temp;
                }
            }
        }


        if (index != currentPageIndex)
        {
            currentPageIndex = index;
            OnPageChanged?.Invoke(pages.Count, currentPageIndex);
        }

        targetHOrV = pages[index];

        if (eventData != null)
            OnPageDragEnd?.Invoke(eventData.position.x - lastPosX);
    }

    void UpdatePages()
    {
        // 获取子对象的数量
        int count = this.rect.content.childCount;
        int temp = 0;
        for (int i = 0; i < count; i++)
        {
            if (this.rect.content.GetChild(i).gameObject.activeSelf)
            {
                temp++;
            }
        }
        count = temp;

        if (pages.Count != count)
        {
            if (count != 0)
            {
                pages.Clear();
                for (int i = 0; i < count; i++)
                {
                    float page = 0;
                    if (count != 1)
                        page = i / ((float)(count - 1));
                    pages.Add(page);
                }
            }
            OnEndDrag(null);
        }
    }

    public void OnDrag(PointerEventData eventData)
    {
        OnPageDrag?.Invoke(eventData.position.x - lastPosX);
    }
}

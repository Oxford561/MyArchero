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
using System;

namespace SYJFramework
{


    public enum UILevel
    {
        Bottom,// 底部
        Common,// 通用
        Pop,   // 弹出
        Top    // 顶部
    }

    /// <summary>
    /// 每个 UI 对应的 Data
    /// </summary>
    public interface IUIData
    {

    }



    /// <summary>
    /// UI 管理器
    /// </summary>
    public class UIManager : IDisposable
    {
        private Transform mUIRootTrans;
        private Transform mUIBottomTrans;
        private Transform mUICommonTrans;
        private Transform mUIPopTrans;
        private Transform mUITopTrans;

        /// <summary>
        /// 已经打开的 UI 窗口链表
        /// </summary>
        private Dictionary<string, UIPanel> uiPanelDic;

        /// <summary>
        /// 收集隐藏的UI
        /// </summary>
        private LinkedList<UIPanel> cacheUIPanelList;
        /// <summary>
        /// UI 隐藏后失效的时间
        /// </summary>
        private float UIExpire = 10f;

        public UIManager()
        {
            uiPanelDic = new Dictionary<string, UIPanel>();
            cacheUIPanelList = new LinkedList<UIPanel>();

            //生成 UIRoot
            CreateUIRoot();
        }

        private void CreateUIRoot()
        {
            var uiRoot = GameEntry.Instance.transform.Find("UIRoot").gameObject;
            if (!uiRoot)
                uiRoot = Resources.Load<GameObject>("UIRoot");

            mUIRootTrans = uiRoot.transform;
            mUIBottomTrans = mUIRootTrans.Find("Bottom");
            mUICommonTrans = mUIRootTrans.Find("Common");
            mUIPopTrans = mUIRootTrans.Find("Pop");
            mUITopTrans = mUIRootTrans.Find("Top");

            mUIRootTrans.SetParent(GameEntry.Instance.transform);
        }

        /// <summary>
        /// 打开 UI
        /// </summary>
        public UIPanel OpenUI(string uiName, UILevel level = UILevel.Common, IUIData uiData = null)
        {
            UIPanel uiPanel = null;
            if (!uiPanelDic.TryGetValue(uiName, out uiPanel))
            {
                uiPanel = CreateUI(uiName, level);
            }


            uiPanel.Open(uiData);
            return uiPanel;
        }

        /// <summary>
        /// 创建 UI
        /// </summary>
        /// <param name="uiName"></param>
        /// <param name="level"></param>
        /// <returns></returns>
        private UIPanel CreateUI(string uiName, UILevel level)
        {
            UIPanel uiPanel = null;

            uiPanel = UITool.Load(uiName);

            if (uiPanel == null)
            {
                Debug.LogError("当前 UIPanel 不存在");
                return null;
            }

            switch (level)
            {
                case UILevel.Bottom:
                    uiPanel.transform.SetParent(mUIBottomTrans, false);
                    break;
                case UILevel.Common:
                    uiPanel.transform.SetParent(mUICommonTrans, false);
                    break;
                case UILevel.Pop:
                    uiPanel.transform.SetParent(mUIPopTrans, false);
                    break;
                case UILevel.Top:
                    uiPanel.transform.SetParent(mUITopTrans, false);
                    break;
            }

            var uiRecTrans = uiPanel.transform as RectTransform;
            uiRecTrans.offsetMin = Vector2.zero;
            uiRecTrans.offsetMax = Vector2.zero;
            uiRecTrans.anchoredPosition = Vector3.zero;
            uiRecTrans.anchorMin = Vector2.zero;
            uiRecTrans.anchorMax = Vector2.one;
            uiRecTrans.localScale = Vector2.one;

            uiPanel.transform.gameObject.name = uiName;

            uiPanelDic.Add(uiName, uiPanel);

            return uiPanel;
        }

        /// <summary>
        /// 获取UI
        /// </summary>
        /// <param name="uiName"></param>
        /// <returns></returns>
        public UIPanel GetUI(string uiName)
        {
            UIPanel uiPanel = null;
            if (uiPanelDic.TryGetValue(uiName, out uiPanel))
            {
                return uiPanel;
            }
            Debug.LogError("获取 UI 失败，UI未生成");
            return null;
        }

        public void OnUpdate()
        {
            for (LinkedListNode<UIPanel> curr = cacheUIPanelList.First; curr != null;)
            {
                if (Time.time > curr.Value.CloseTime + UIExpire)
                {
                    // 销毁UI
                    UnityEngine.Object.Destroy(curr.Value.gameObject);
                    LinkedListNode<UIPanel> next = curr.Next;
                    Debug.Log("删除 " + curr.Value.name);
                    uiPanelDic.Remove(curr.Value.name);
                    cacheUIPanelList.Remove(curr.Value);
                    curr = next;
                }
                else
                {
                    curr = curr.Next;
                }
            }
        }

        public void CloseUI(string uiName)
        {
            UIPanel uiPanel = null;
            if (uiPanelDic.TryGetValue(uiName, out uiPanel))
            {
                cacheUIPanelList.AddLast(uiPanel);

                uiPanel.Close();

                return;
            }

            Debug.LogError("关闭 UI 失败，UI未生成");
        }

        public void CloseSelf(UIPanel ui)
        {
            CloseUI(ui.name);
        }

        public void Dispose()
        {
            uiPanelDic.Clear();
        }
    }
}
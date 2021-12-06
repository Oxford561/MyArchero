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

    public class TimeManager : IDisposable
    {
        private LinkedList<TimeAction> m_TimeActionList;

        internal TimeManager()
        {
            m_TimeActionList = new LinkedList<TimeAction>();
        }

        public void AddTimeAction(TimeAction action)
        {
            m_TimeActionList.AddLast(action);
        }

        public void RemoveTimeAction(TimeAction action)
        {
            m_TimeActionList.Remove(action);
            GameEntry.Pool.EnqueueClassObject(action);
        }

        public TimeAction CreateTimeAction()
        {
            return GameEntry.Pool.DequeueClassObject<TimeAction>();
        }

        /// <summary>
		/// 修改时间缩放
		/// </summary>
		/// <param name="toTimeScale">缩放的值</param>
		/// <param name="continueTime">持续时间</param>
		public void ChangeTimeScale(float toTimeScale, float continueTime)
        {
            Time.timeScale = toTimeScale;
            GameEntry.Time.CreateTimeAction().Init(continueTime, 0, 0, () =>
            {
                Time.timeScale = 1;
            }).Run();
        }

        /// <summary>
        /// 延迟一帧
        /// </summary>
        /// <param name="onComplete"></param>
        public void Yield(BaseAction onComplete)
        {
            GameEntry.Instance.StartCoroutine(YieldCoroutine(onComplete));
        }

        private IEnumerator YieldCoroutine(BaseAction onComplete)
        {
            yield return null;
            if (onComplete != null) onComplete();
        }

        public void OnUpdate()
        {
            for (LinkedListNode<TimeAction> curr = m_TimeActionList.First; curr != null; curr = curr.Next)
            {
                curr.Value.OnUpdate();
            }
        }
        public void Dispose()
        {
            m_TimeActionList.Clear();
        }
    }
}
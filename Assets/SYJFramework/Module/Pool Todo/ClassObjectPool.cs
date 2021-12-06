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

/// <summary>
/// 类对象池
/// </summary>
public class ClassObjectPool : IDisposable
{
    /// <summary>
    /// 类对象池中的常驻数量
    /// </summary>
    /// <value></value>
    public Dictionary<int, byte> ClassObjectCount { get; private set; }

    /// <summary>
    /// 类对象池字典
    /// </summary>
    private Dictionary<int, Queue<object>> m_ClassObjectPoolDic;

#if UNITY_EDITOR
    /// <summary>
    /// 在监视面板显示的信息
    /// </summary>
    public Dictionary<Type, int> InspectorDic = new Dictionary<Type, int>();
#endif

    public ClassObjectPool()
    {
        m_ClassObjectPoolDic = new Dictionary<int, Queue<object>>();

        ClassObjectCount = new Dictionary<int, byte>();
    }

    #region SetResideCount 设置常驻数量
    /// <summary>
    /// 设置常驻数量
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="count"></param>
    public void SetResideCount<T>(byte count) where T : class
    {
        int key = typeof(T).GetHashCode();
        ClassObjectCount[key] = count;
    }
    #endregion


    #region Dequeue 取出一个对象
    /// <summary>
    /// 取出一个对象
    /// </summary>
    /// <typeparam name="T">对象类型</typeparam>
    /// <returns>对象</returns>
    public T Dequeue<T>() where T : class, new()
    {
        lock (m_ClassObjectPoolDic)
        {
            //1.找到该类的哈希码
            int key = typeof(T).GetHashCode();

            Queue<object> queue = null;
            m_ClassObjectPoolDic.TryGetValue(key, out queue);

            if (queue == null)
            {
                queue = new Queue<object>();
                m_ClassObjectPoolDic[key] = queue;
            }

            //2.获取对象
            if (queue.Count > 0)
            {
                //说明队列中 有闲置的
                object obj = queue.Dequeue();
#if UNITY_EDITOR
                Type type = obj.GetType();
                if (InspectorDic.ContainsKey(type))
                {
                    InspectorDic[type]--;
                }
                else
                {
                    InspectorDic[type] = 0;
                }
#endif

                return (T)obj;
            }
            else
            {
                //如果队列中没有 则实例化
                return new T();
            }
        }
    }
    #endregion

    #region Enqueue 对象回池
    /// <summary>
    /// 对象回池
    /// </summary>
    /// <param name="obj"></param>
    public void Enqueue(object obj)
    {
        lock (m_ClassObjectPoolDic)
        {
            int key = obj.GetType().GetHashCode();

            Queue<object> queue = null;
            m_ClassObjectPoolDic.TryGetValue(key, out queue);

#if UNITY_EDITOR
            Type type = obj.GetType();
            if (InspectorDic.ContainsKey(type))
            {
                InspectorDic[type]++;
            }
            else
            {
                InspectorDic[type] = 1;
            }
#endif

            if (queue != null)
            {
                queue.Enqueue(obj);
            }
        }
    }
    #endregion

    #region Clear 释放类对象池
    /// <summary>
    /// 释放类对象池
    /// </summary>
    public void Clear()
    {
        lock (m_ClassObjectPoolDic)
        {
            int queueCount = 0; //队列的数量

            //获取迭代器
            var enumerator = m_ClassObjectPoolDic.GetEnumerator();
            while (enumerator.MoveNext())
            {
                int key = enumerator.Current.Key;

                //获取队列
                Queue<object> queue = m_ClassObjectPoolDic[key];
#if UNITY_EDITOR
                Type type = null;
#endif
                queueCount = queue.Count;

                byte resideCount = 0;
                ClassObjectCount.TryGetValue(key, out resideCount);
                while (queueCount > resideCount) //说明队列中有可释放的对象
                {
                    queueCount--;
                    object obj = queue.Dequeue(); //从队列中取出一个对象没有任何地方的引用 就会等待GC回收

#if UNITY_EDITOR
                    type = obj.GetType();
                    InspectorDic[type]--;
#endif
                }

                if (queueCount == 0)
                {
#if UNITY_EDITOR
                    if (type != null) InspectorDic.Remove(type);
#endif
                }
            }

            //GC 整个项目中,有一处调用即可
            GC.Collect();
        }
    }
    #endregion

    public void Dispose()
    {
        m_ClassObjectPoolDic.Clear();
    }
}
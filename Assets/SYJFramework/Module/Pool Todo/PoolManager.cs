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

public class PoolManager : IDisposable
{
    /// <summary>
    /// 类对象池
    /// </summary>
    public ClassObjectPool ClassObjectPool
    {
        get;
        private set;
    }

    /// <summary>
    /// 游戏物体对象池
    /// </summary>
    public GameObjectPool GameObjectPool
    {
        get;
        private set;
    }

    public PoolManager()
    {
        ClassObjectPool = new ClassObjectPool();
        GameObjectPool = new GameObjectPool();
    }

    /// <summary>
    /// 取出一个类对象
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public T DequeueClassObject<T>() where T : class, new()
    {
        return ClassObjectPool.Dequeue<T>();
    }

    /// <summary>
    /// 类对象 回池
    /// </summary>
    /// <param name="obj"></param>
    public void EnqueueClassObject(object obj)
    {
        ClassObjectPool.Enqueue(obj);
    }

    /// <summary>
    /// 释放类对象池
    /// </summary>
    public void ReleaseClassObjectPool()
    {
        ClassObjectPool.Clear();
    }

    public void Dispose()
    {
        ClassObjectPool.Dispose();
        GameObjectPool.Dispose();
    }
}
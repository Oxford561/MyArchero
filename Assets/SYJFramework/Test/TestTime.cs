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
using SYJFramework;
using UnityEngine;

/// <summary>
/// 测试定时器
/// </summary>
public class TestTime : MonoBehaviour
{
    void Start()
    {
        TimeAction action = GameEntry.Time.CreateTimeAction();
        action.Init(2f, 5f, 5, () =>
        {
            Debug.Log("开始");
        }, (int loop) =>
        {
            Debug.Log("循环次数 " + loop);
        }, () =>
        {
            Debug.Log("结束");
        }).Run();

    }

    void Update()
    {

    }
}
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

public class TestHttp : MonoBehaviour
{
    // Use this for initialization
    void Start()
    {
        Debug.Log("发送请求");
        GameEntry.Http.Get("https://www.tianqiapi.com/api/", (HttpCallBackArgs args) =>
        {
            Debug.Log(args.HasError + " " + args.Value);
        }, true);
    }

    // Update is called once per frame
    void Update()
    {

    }
}
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
using SYJFramework;

public class TestRes : MonoBehaviour
{
    void Start()
    {
        #region Resources 加载资源测试 同步和异步
        // var go = GameEntry.Res.Loader.LoadSync<GameObject>("resources://Cube");
        // Instantiate(go);
        // GameEntry.Res.Loader.ReleaseAll();
        // GameEntry.Res.Loader = null;

        // GameEntry.Res.Loader.LoadAsync<GameObject>("resources://Cube", (GameObject target) =>
        // {
        //     Instantiate(target);
        //     GameEntry.Res.Loader.ReleaseAll();
        //     GameEntry.Res.Loader = null;
        // });
        #endregion

        #region AssetBundle 加载资源测试 同步和异步

        // 如果 bundle名称和 资源名称相同 会出现异常，提示重复加载（使用 AssetRes 会先加载 Bundle 再去加载 Asset）
        //var go = GameEntry.Res.Loader.LoadSync<GameObject>("Cube", "Cube");// bundle名称  资源名称
        // Instantiate(go);

        // GameEntry.Res.Loader.LoadAsync<GameObject>("cube","Cube", (GameObject target) =>
        // {
        // 	Instantiate(target);
        // });

        #endregion

        #region 直接通过 Asset 名称 加载 AssetBundle 资源

        var go = GameEntry.Res.Loader.LoadSync<GameObject>("Cube");//它会去加载 AssetBundle 然后加载不了资源

        Instantiate(go);

        #endregion

    }

    void Update()
    {

    }

    private void OnDestroy()
    {
        GameEntry.Res.Loader.ReleaseAll();
        GameEntry.Res.Loader = null;
    }
}
// Upgrade NOTE: commented out 'float4 unity_ShadowFadeCenterAndType', a built-in variable

Shader "Hidden/Internal-PrePassLighting"
{
  Properties
  {
    _LightTexture0 ("", any) = "" {}
    _LightTextureB0 ("", 2D) = "" {}
    _ShadowMapTexture ("", any) = "" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend DstColor Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float _LightAsQuad;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      // uniform float4 unity_ShadowFadeCenterAndType;
      uniform sampler2D _CameraDepthTexture;
      uniform float4 _LightPos;
      uniform float4 _LightColor;
      uniform float4 unity_LightmapFade;
      uniform sampler2D _LightTextureB0;
      uniform sampler2D _CameraNormalsTexture;
      uniform float4 _CameraNormalsTexture_ST;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1 = in_v.vertex;
          float3 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_4.w = 1;
          tmpvar_4.xyz = float3(tmpvar_1.xyz);
          tmpvar_3 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_4));
          float4 o_5;
          float4 tmpvar_6;
          tmpvar_6 = (tmpvar_3 * 0.5);
          float2 tmpvar_7;
          tmpvar_7.x = tmpvar_6.x;
          tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
          o_5.xy = float2((tmpvar_7 + tmpvar_6.w));
          o_5.zw = tmpvar_3.zw;
          float4 tmpvar_8;
          tmpvar_8.w = 1;
          tmpvar_8.xyz = float3(tmpvar_1.xyz);
          tmpvar_2 = (mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_8)).xyz * float3(-1, (-1), 1));
          float3 tmpvar_9;
          tmpvar_9 = lerp(tmpvar_2, in_v.normal, float3(_LightAsQuad, _LightAsQuad, _LightAsQuad));
          tmpvar_2 = tmpvar_9;
          out_v.vertex = tmpvar_3;
          out_v.xlv_TEXCOORD0 = o_5;
          out_v.xlv_TEXCOORD1 = tmpvar_9;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 res_2;
          float spec_3;
          float3 h_4;
          float4 nspec_5;
          float atten_6;
          float3 lightDir_7;
          float2 tmpvar_8;
          tmpvar_8 = (in_f.xlv_TEXCOORD0.xy / in_f.xlv_TEXCOORD0.w);
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = float3(((in_f.xlv_TEXCOORD1 * (_ProjectionParams.z / in_f.xlv_TEXCOORD1.z)) * (1 / ((_ZBufferParams.x * tex2D(_CameraDepthTexture, tmpvar_8).x) + _ZBufferParams.y))));
          float3 tmpvar_10;
          tmpvar_10 = mul(unity_CameraToWorld, tmpvar_9).xyz.xyz;
          float3 tmpvar_11;
          tmpvar_11 = (tmpvar_10 - unity_ShadowFadeCenterAndType.xyz);
          float3 tmpvar_12;
          tmpvar_12 = (tmpvar_10 - _LightPos.xyz);
          float3 tmpvar_13;
          tmpvar_13 = (-normalize(tmpvar_12));
          lightDir_7 = tmpvar_13;
          float _tmp_dvx_68 = (dot(tmpvar_12, tmpvar_12) * _LightPos.w);
          atten_6 = tex2D(_LightTextureB0, float2(_tmp_dvx_68, _tmp_dvx_68)).w.x;
          float4 tmpvar_14;
          float2 P_15;
          P_15 = TRANSFORM_TEX(tmpvar_8, _CameraNormalsTexture);
          tmpvar_14 = tex2D(_CameraNormalsTexture, P_15);
          nspec_5 = tmpvar_14;
          float3 tmpvar_16;
          tmpvar_16 = normalize(((nspec_5.xyz * 2) - 1));
          float3 tmpvar_17;
          tmpvar_17 = normalize((lightDir_7 - normalize((tmpvar_10 - _WorldSpaceCameraPos))));
          h_4 = tmpvar_17;
          float tmpvar_18;
          tmpvar_18 = pow(max(0, dot(h_4, tmpvar_16)), (nspec_5.w * 128));
          spec_3 = tmpvar_18;
          spec_3 = (spec_3 * clamp(atten_6, 0, 1));
          res_2.xyz = float3((_LightColor.xyz * (max(0, dot(lightDir_7, tmpvar_16)) * atten_6)));
          float3 rgb_19;
          rgb_19 = _LightColor.xyz;
          res_2.w = (spec_3 * dot(rgb_19, float3(0.22, 0.707, 0.071)));
          float tmpvar_20;
          tmpvar_20 = clamp((1 - ((lerp(tmpvar_9.z, sqrt(dot(tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0, 1);
          res_2 = (res_2 * tmpvar_20);
          float4 tmpvar_21;
          tmpvar_21 = exp2((-res_2));
          tmpvar_1 = tmpvar_21;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float _LightAsQuad;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      // uniform float4 unity_ShadowFadeCenterAndType;
      uniform sampler2D _CameraDepthTexture;
      uniform float4 _LightPos;
      uniform float4 _LightColor;
      uniform float4 unity_LightmapFade;
      uniform sampler2D _LightTextureB0;
      uniform sampler2D _CameraNormalsTexture;
      uniform float4 _CameraNormalsTexture_ST;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1 = in_v.vertex;
          float3 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_4.w = 1;
          tmpvar_4.xyz = float3(tmpvar_1.xyz);
          tmpvar_3 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_4));
          float4 o_5;
          float4 tmpvar_6;
          tmpvar_6 = (tmpvar_3 * 0.5);
          float2 tmpvar_7;
          tmpvar_7.x = tmpvar_6.x;
          tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
          o_5.xy = float2((tmpvar_7 + tmpvar_6.w));
          o_5.zw = tmpvar_3.zw;
          float4 tmpvar_8;
          tmpvar_8.w = 1;
          tmpvar_8.xyz = float3(tmpvar_1.xyz);
          tmpvar_2 = (mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_8)).xyz * float3(-1, (-1), 1));
          float3 tmpvar_9;
          tmpvar_9 = lerp(tmpvar_2, in_v.normal, float3(_LightAsQuad, _LightAsQuad, _LightAsQuad));
          tmpvar_2 = tmpvar_9;
          out_v.vertex = tmpvar_3;
          out_v.xlv_TEXCOORD0 = o_5;
          out_v.xlv_TEXCOORD1 = tmpvar_9;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 res_2;
          float spec_3;
          float3 h_4;
          float4 nspec_5;
          float atten_6;
          float3 lightDir_7;
          float2 tmpvar_8;
          tmpvar_8 = (in_f.xlv_TEXCOORD0.xy / in_f.xlv_TEXCOORD0.w);
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = float3(((in_f.xlv_TEXCOORD1 * (_ProjectionParams.z / in_f.xlv_TEXCOORD1.z)) * (1 / ((_ZBufferParams.x * tex2D(_CameraDepthTexture, tmpvar_8).x) + _ZBufferParams.y))));
          float3 tmpvar_10;
          tmpvar_10 = mul(unity_CameraToWorld, tmpvar_9).xyz.xyz;
          float3 tmpvar_11;
          tmpvar_11 = (tmpvar_10 - unity_ShadowFadeCenterAndType.xyz);
          float3 tmpvar_12;
          tmpvar_12 = (tmpvar_10 - _LightPos.xyz);
          float3 tmpvar_13;
          tmpvar_13 = (-normalize(tmpvar_12));
          lightDir_7 = tmpvar_13;
          float _tmp_dvx_69 = (dot(tmpvar_12, tmpvar_12) * _LightPos.w);
          atten_6 = tex2D(_LightTextureB0, float2(_tmp_dvx_69, _tmp_dvx_69)).w.x;
          float4 tmpvar_14;
          float2 P_15;
          P_15 = TRANSFORM_TEX(tmpvar_8, _CameraNormalsTexture);
          tmpvar_14 = tex2D(_CameraNormalsTexture, P_15);
          nspec_5 = tmpvar_14;
          float3 tmpvar_16;
          tmpvar_16 = normalize(((nspec_5.xyz * 2) - 1));
          float3 tmpvar_17;
          tmpvar_17 = normalize((lightDir_7 - normalize((tmpvar_10 - _WorldSpaceCameraPos))));
          h_4 = tmpvar_17;
          float tmpvar_18;
          tmpvar_18 = pow(max(0, dot(h_4, tmpvar_16)), (nspec_5.w * 128));
          spec_3 = tmpvar_18;
          spec_3 = (spec_3 * clamp(atten_6, 0, 1));
          res_2.xyz = float3((_LightColor.xyz * (max(0, dot(lightDir_7, tmpvar_16)) * atten_6)));
          float3 rgb_19;
          rgb_19 = _LightColor.xyz;
          res_2.w = (spec_3 * dot(rgb_19, float3(0.22, 0.707, 0.071)));
          float tmpvar_20;
          tmpvar_20 = clamp((1 - ((lerp(tmpvar_9.z, sqrt(dot(tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0, 1);
          res_2 = (res_2 * tmpvar_20);
          tmpvar_1 = res_2;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

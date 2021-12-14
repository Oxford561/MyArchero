Shader "Hidden/Internal-ScreenSpaceShadows"
{
  Properties
  {
    _ShadowMapTexture ("", any) = "" {}
    _ODSWorldTexture ("", 2D) = "" {}
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "HardShadow"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "HardShadow"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ZBufferParams;
      //uniform float4 unity_OrthoParams;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4x4x4 unity_WorldToShadow;
      //uniform float4 _LightShadowData;
      uniform sampler2D _ShadowMapTexture;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float3 orthoPosFar_1;
          float3 orthoPosNear_2;
          float4 clipPos_3;
          float4 tmpvar_4;
          float4 tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(in_v.vertex.xyz);
          tmpvar_5 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_6));
          clipPos_3.xzw = tmpvar_5.xzw;
          tmpvar_4.xy = float2(in_v.texcoord.xy);
          float4 o_7;
          float4 tmpvar_8;
          tmpvar_8 = (tmpvar_5 * 0.5);
          float2 tmpvar_9;
          tmpvar_9.x = tmpvar_8.x;
          tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
          o_7.xy = float2((tmpvar_9 + tmpvar_8.w));
          o_7.zw = tmpvar_5.zw;
          tmpvar_4.zw = o_7.xy;
          clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
          float4 tmpvar_10;
          tmpvar_10.zw = float2(-1, 1);
          tmpvar_10.xy = float2(clipPos_3.xy);
          float3 tmpvar_11;
          tmpvar_11 = mul(unity_CameraInvProjection, tmpvar_10).xyz.xyz;
          orthoPosNear_2.xy = float2(tmpvar_11.xy);
          float4 tmpvar_12;
          tmpvar_12.zw = float2(1, 1);
          tmpvar_12.xy = float2(clipPos_3.xy);
          float3 tmpvar_13;
          tmpvar_13 = mul(unity_CameraInvProjection, tmpvar_12).xyz.xyz;
          orthoPosFar_1.xy = float2(tmpvar_13.xy);
          orthoPosNear_2.z = (-tmpvar_11.z);
          orthoPosFar_1.z = (-tmpvar_13.z);
          out_v.vertex = tmpvar_5;
          out_v.xlv_TEXCOORD0 = tmpvar_4;
          out_v.xlv_TEXCOORD1 = in_v.texcoord1.xyz;
          out_v.xlv_TEXCOORD2 = orthoPosNear_2;
          out_v.xlv_TEXCOORD3 = orthoPosFar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float shadow_1;
          float4 wpos_2;
          float3 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_4 = tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0.xy);
          tmpvar_3 = lerp((in_f.xlv_TEXCOORD1 * lerp((1 / ((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)), tmpvar_4.x, unity_OrthoParams.w)), lerp(in_f.xlv_TEXCOORD2, in_f.xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(tmpvar_3);
          wpos_2 = mul(unity_CameraToWorld, tmpvar_5);
          float4 tmpvar_6;
          tmpvar_6 = bool4(tmpvar_3.zzzz >= _LightSplitsNear);
          float4 tmpvar_7;
          tmpvar_7 = bool4(tmpvar_3.zzzz < _LightSplitsFar);
          float4 tmpvar_8;
          tmpvar_8 = (float4(tmpvar_6) * float4(tmpvar_7));
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = (((mul(mul(((float4[16])unity_WorldToShadow)[0], wpos_2).xyz, tmpvar_8.x) + mul(mul(((float4[16])unity_WorldToShadow)[1], wpos_2).xyz, tmpvar_8.y)) + mul(mul(((float4[16])unity_WorldToShadow)[2], wpos_2).xyz, tmpvar_8.z)) + mul(mul(((float4[16])unity_WorldToShadow)[3], wpos_2).xyz, tmpvar_8.w)).xyz;
          float4 tmpvar_10;
          tmpvar_10 = tex2D(_ShadowMapTexture, tmpvar_9.xy);
          float tmpvar_11;
          if((tmpvar_10.x<tmpvar_9.z))
          {
              tmpvar_11 = 0;
          }
          else
          {
              tmpvar_11 = 1;
          }
          float tmpvar_12;
          tmpvar_12 = lerp(_LightShadowData.x, 1, tmpvar_11);
          shadow_1 = tmpvar_12;
          float4 tmpvar_13;
          tmpvar_13 = float4(shadow_1, shadow_1, shadow_1, shadow_1);
          out_f.color = tmpvar_13;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4x4x4 unity_WorldToShadow;
      //uniform float4 _LightShadowData;
      uniform sampler2D _ShadowMapTexture;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float3 orthoPosFar_1;
          float3 orthoPosNear_2;
          float4 clipPos_3;
          float4 tmpvar_4;
          float4 tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(in_v.vertex.xyz);
          tmpvar_5 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_6));
          clipPos_3.xzw = tmpvar_5.xzw;
          tmpvar_4.xy = float2(in_v.texcoord.xy);
          float4 o_7;
          float4 tmpvar_8;
          tmpvar_8 = (tmpvar_5 * 0.5);
          float2 tmpvar_9;
          tmpvar_9.x = tmpvar_8.x;
          tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
          o_7.xy = float2((tmpvar_9 + tmpvar_8.w));
          o_7.zw = tmpvar_5.zw;
          tmpvar_4.zw = o_7.xy;
          clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
          float4 tmpvar_10;
          tmpvar_10.zw = float2(-1, 1);
          tmpvar_10.xy = float2(clipPos_3.xy);
          float3 tmpvar_11;
          tmpvar_11 = mul(unity_CameraInvProjection, tmpvar_10).xyz.xyz;
          orthoPosNear_2.xy = float2(tmpvar_11.xy);
          float4 tmpvar_12;
          tmpvar_12.zw = float2(1, 1);
          tmpvar_12.xy = float2(clipPos_3.xy);
          float3 tmpvar_13;
          tmpvar_13 = mul(unity_CameraInvProjection, tmpvar_12).xyz.xyz;
          orthoPosFar_1.xy = float2(tmpvar_13.xy);
          orthoPosNear_2.z = (-tmpvar_11.z);
          orthoPosFar_1.z = (-tmpvar_13.z);
          out_v.vertex = tmpvar_5;
          out_v.xlv_TEXCOORD0 = tmpvar_4;
          out_v.xlv_TEXCOORD1 = in_v.texcoord1.xyz;
          out_v.xlv_TEXCOORD2 = orthoPosNear_2;
          out_v.xlv_TEXCOORD3 = orthoPosFar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float shadow_1;
          float4 wpos_2;
          float4 camPos_3;
          float4 clipPos_4;
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xy = float2(in_f.xlv_TEXCOORD0.zw);
          tmpvar_5.z = tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0.xy).x;
          clipPos_4.w = tmpvar_5.w;
          float _tmp_dvx_70 = ((2 * tmpvar_5.xyz) - 1);
          clipPos_4.xyz = float3(_tmp_dvx_70, _tmp_dvx_70, _tmp_dvx_70);
          float4 tmpvar_6;
          tmpvar_6 = mul(unity_CameraInvProjection, clipPos_4);
          camPos_3.w = tmpvar_6.w;
          camPos_3.xyz = float3((tmpvar_6.xyz / tmpvar_6.w));
          camPos_3.z = (-camPos_3.z);
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = float3(camPos_3.xyz);
          wpos_2 = mul(unity_CameraToWorld, tmpvar_7);
          float4 tmpvar_8;
          tmpvar_8 = bool4(camPos_3.zzzz >= _LightSplitsNear);
          float4 tmpvar_9;
          tmpvar_9 = bool4(camPos_3.zzzz < _LightSplitsFar);
          float4 tmpvar_10;
          tmpvar_10 = (float4(tmpvar_8) * float4(tmpvar_9));
          float4 tmpvar_11;
          tmpvar_11.w = 1;
          tmpvar_11.xyz = (((mul(mul(((float4[16])unity_WorldToShadow)[0], wpos_2).xyz, tmpvar_10.x) + mul(mul(((float4[16])unity_WorldToShadow)[1], wpos_2).xyz, tmpvar_10.y)) + mul(mul(((float4[16])unity_WorldToShadow)[2], wpos_2).xyz, tmpvar_10.z)) + mul(mul(((float4[16])unity_WorldToShadow)[3], wpos_2).xyz, tmpvar_10.w)).xyz;
          float4 tmpvar_12;
          tmpvar_12 = tex2D(_ShadowMapTexture, tmpvar_11.xy);
          float tmpvar_13;
          if((tmpvar_12.x<tmpvar_11.z))
          {
              tmpvar_13 = 0;
          }
          else
          {
              tmpvar_13 = 1;
          }
          float tmpvar_14;
          tmpvar_14 = lerp(_LightShadowData.x, 1, tmpvar_13);
          shadow_1 = tmpvar_14;
          float4 tmpvar_15;
          tmpvar_15 = float4(shadow_1, shadow_1, shadow_1, shadow_1);
          out_f.color = tmpvar_15;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "PCF_SOFT"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "PCF_SOFT"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ZBufferParams;
      //uniform float4 unity_OrthoParams;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4x4x4 unity_WorldToShadow;
      //uniform float4 _LightShadowData;
      uniform sampler2D _ShadowMapTexture;
      uniform float4 _ShadowMapTexture_TexelSize;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float3 orthoPosFar_1;
          float3 orthoPosNear_2;
          float4 clipPos_3;
          float4 tmpvar_4;
          float4 tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(in_v.vertex.xyz);
          tmpvar_5 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_6));
          clipPos_3.xzw = tmpvar_5.xzw;
          tmpvar_4.xy = float2(in_v.texcoord.xy);
          float4 o_7;
          float4 tmpvar_8;
          tmpvar_8 = (tmpvar_5 * 0.5);
          float2 tmpvar_9;
          tmpvar_9.x = tmpvar_8.x;
          tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
          o_7.xy = float2((tmpvar_9 + tmpvar_8.w));
          o_7.zw = tmpvar_5.zw;
          tmpvar_4.zw = o_7.xy;
          clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
          float4 tmpvar_10;
          tmpvar_10.zw = float2(-1, 1);
          tmpvar_10.xy = float2(clipPos_3.xy);
          float3 tmpvar_11;
          tmpvar_11 = mul(unity_CameraInvProjection, tmpvar_10).xyz.xyz;
          orthoPosNear_2.xy = float2(tmpvar_11.xy);
          float4 tmpvar_12;
          tmpvar_12.zw = float2(1, 1);
          tmpvar_12.xy = float2(clipPos_3.xy);
          float3 tmpvar_13;
          tmpvar_13 = mul(unity_CameraInvProjection, tmpvar_12).xyz.xyz;
          orthoPosFar_1.xy = float2(tmpvar_13.xy);
          orthoPosNear_2.z = (-tmpvar_11.z);
          orthoPosFar_1.z = (-tmpvar_13.z);
          out_v.vertex = tmpvar_5;
          out_v.xlv_TEXCOORD0 = tmpvar_4;
          out_v.xlv_TEXCOORD1 = in_v.texcoord1.xyz;
          out_v.xlv_TEXCOORD2 = orthoPosNear_2;
          out_v.xlv_TEXCOORD3 = orthoPosFar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 wpos_2;
          float3 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_4 = tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0.xy);
          tmpvar_3 = lerp((in_f.xlv_TEXCOORD1 * lerp((1 / ((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)), tmpvar_4.x, unity_OrthoParams.w)), lerp(in_f.xlv_TEXCOORD2, in_f.xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(tmpvar_3);
          wpos_2 = mul(unity_CameraToWorld, tmpvar_5);
          float4 tmpvar_6;
          tmpvar_6 = bool4(tmpvar_3.zzzz >= _LightSplitsNear);
          float4 tmpvar_7;
          tmpvar_7 = bool4(tmpvar_3.zzzz < _LightSplitsFar);
          float4 tmpvar_8;
          tmpvar_8 = (float4(tmpvar_6) * float4(tmpvar_7));
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = (((mul(mul(((float4[16])unity_WorldToShadow)[0], wpos_2).xyz, tmpvar_8.x) + mul(mul(((float4[16])unity_WorldToShadow)[1], wpos_2).xyz, tmpvar_8.y)) + mul(mul(((float4[16])unity_WorldToShadow)[2], wpos_2).xyz, tmpvar_8.z)) + mul(mul(((float4[16])unity_WorldToShadow)[3], wpos_2).xyz, tmpvar_8.w)).xyz;
          float shadow_10;
          float2 tmpvar_11;
          tmpvar_11 = _ShadowMapTexture_TexelSize.xy;
          shadow_10 = 0;
          float3 tmpvar_12;
          tmpvar_12.xy = float2((tmpvar_9.xy - _ShadowMapTexture_TexelSize.xy));
          tmpvar_12.z = tmpvar_9.z;
          float4 tmpvar_13;
          tmpvar_13 = tex2D(_ShadowMapTexture, tmpvar_12.xy);
          float tmpvar_14;
          if((tmpvar_13.x<tmpvar_9.z))
          {
              tmpvar_14 = 0;
          }
          else
          {
              tmpvar_14 = 1;
          }
          shadow_10 = tmpvar_14;
          float2 tmpvar_15;
          tmpvar_15.x = 0;
          tmpvar_15.y = (-_ShadowMapTexture_TexelSize.y);
          float3 tmpvar_16;
          tmpvar_16.xy = float2((tmpvar_9.xy + tmpvar_15));
          tmpvar_16.z = tmpvar_9.z;
          float4 tmpvar_17;
          tmpvar_17 = tex2D(_ShadowMapTexture, tmpvar_16.xy);
          float tmpvar_18;
          if((tmpvar_17.x<tmpvar_9.z))
          {
              tmpvar_18 = 0;
          }
          else
          {
              tmpvar_18 = 1;
          }
          shadow_10 = (tmpvar_14 + tmpvar_18);
          float2 tmpvar_19;
          tmpvar_19.x = tmpvar_11.x;
          tmpvar_19.y = (-_ShadowMapTexture_TexelSize.y);
          float3 tmpvar_20;
          tmpvar_20.xy = float2((tmpvar_9.xy + tmpvar_19));
          tmpvar_20.z = tmpvar_9.z;
          float4 tmpvar_21;
          tmpvar_21 = tex2D(_ShadowMapTexture, tmpvar_20.xy);
          float tmpvar_22;
          if((tmpvar_21.x<tmpvar_9.z))
          {
              tmpvar_22 = 0;
          }
          else
          {
              tmpvar_22 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_22);
          float2 tmpvar_23;
          tmpvar_23.y = 0;
          tmpvar_23.x = (-_ShadowMapTexture_TexelSize.x);
          float3 tmpvar_24;
          tmpvar_24.xy = float2((tmpvar_9.xy + tmpvar_23));
          tmpvar_24.z = tmpvar_9.z;
          float4 tmpvar_25;
          tmpvar_25 = tex2D(_ShadowMapTexture, tmpvar_24.xy);
          float tmpvar_26;
          if((tmpvar_25.x<tmpvar_9.z))
          {
              tmpvar_26 = 0;
          }
          else
          {
              tmpvar_26 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_26);
          float4 tmpvar_27;
          tmpvar_27 = tex2D(_ShadowMapTexture, tmpvar_9.xy);
          float tmpvar_28;
          if((tmpvar_27.x<tmpvar_9.z))
          {
              tmpvar_28 = 0;
          }
          else
          {
              tmpvar_28 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_28);
          float2 tmpvar_29;
          tmpvar_29.y = 0;
          tmpvar_29.x = tmpvar_11.x;
          float3 tmpvar_30;
          tmpvar_30.xy = float2((tmpvar_9.xy + tmpvar_29));
          tmpvar_30.z = tmpvar_9.z;
          float4 tmpvar_31;
          tmpvar_31 = tex2D(_ShadowMapTexture, tmpvar_30.xy);
          float tmpvar_32;
          if((tmpvar_31.x<tmpvar_9.z))
          {
              tmpvar_32 = 0;
          }
          else
          {
              tmpvar_32 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_32);
          float2 tmpvar_33;
          tmpvar_33.x = (-_ShadowMapTexture_TexelSize.x);
          tmpvar_33.y = tmpvar_11.y;
          float3 tmpvar_34;
          tmpvar_34.xy = float2((tmpvar_9.xy + tmpvar_33));
          tmpvar_34.z = tmpvar_9.z;
          float4 tmpvar_35;
          tmpvar_35 = tex2D(_ShadowMapTexture, tmpvar_34.xy);
          float tmpvar_36;
          if((tmpvar_35.x<tmpvar_9.z))
          {
              tmpvar_36 = 0;
          }
          else
          {
              tmpvar_36 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_36);
          float2 tmpvar_37;
          tmpvar_37.x = 0;
          tmpvar_37.y = tmpvar_11.y;
          float3 tmpvar_38;
          tmpvar_38.xy = float2((tmpvar_9.xy + tmpvar_37));
          tmpvar_38.z = tmpvar_9.z;
          float4 tmpvar_39;
          tmpvar_39 = tex2D(_ShadowMapTexture, tmpvar_38.xy);
          float tmpvar_40;
          if((tmpvar_39.x<tmpvar_9.z))
          {
              tmpvar_40 = 0;
          }
          else
          {
              tmpvar_40 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_40);
          float3 tmpvar_41;
          tmpvar_41.xy = float2((tmpvar_9.xy + _ShadowMapTexture_TexelSize.xy));
          tmpvar_41.z = tmpvar_9.z;
          float4 tmpvar_42;
          tmpvar_42 = tex2D(_ShadowMapTexture, tmpvar_41.xy);
          float tmpvar_43;
          if((tmpvar_42.x<tmpvar_9.z))
          {
              tmpvar_43 = 0;
          }
          else
          {
              tmpvar_43 = 1;
          }
          shadow_10 = (shadow_10 + tmpvar_43);
          shadow_10 = (shadow_10 / 9);
          float4 tmpvar_44;
          tmpvar_44 = float4(lerp(_LightShadowData.x, 1, shadow_10));
          tmpvar_1 = tmpvar_44;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4x4x4 unity_WorldToShadow;
      //uniform float4 _LightShadowData;
      uniform sampler2D _ShadowMapTexture;
      uniform float4 _ShadowMapTexture_TexelSize;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float3 xlv_TEXCOORD3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float3 orthoPosFar_1;
          float3 orthoPosNear_2;
          float4 clipPos_3;
          float4 tmpvar_4;
          float4 tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(in_v.vertex.xyz);
          tmpvar_5 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_6));
          clipPos_3.xzw = tmpvar_5.xzw;
          tmpvar_4.xy = float2(in_v.texcoord.xy);
          float4 o_7;
          float4 tmpvar_8;
          tmpvar_8 = (tmpvar_5 * 0.5);
          float2 tmpvar_9;
          tmpvar_9.x = tmpvar_8.x;
          tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
          o_7.xy = float2((tmpvar_9 + tmpvar_8.w));
          o_7.zw = tmpvar_5.zw;
          tmpvar_4.zw = o_7.xy;
          clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
          float4 tmpvar_10;
          tmpvar_10.zw = float2(-1, 1);
          tmpvar_10.xy = float2(clipPos_3.xy);
          float3 tmpvar_11;
          tmpvar_11 = mul(unity_CameraInvProjection, tmpvar_10).xyz.xyz;
          orthoPosNear_2.xy = float2(tmpvar_11.xy);
          float4 tmpvar_12;
          tmpvar_12.zw = float2(1, 1);
          tmpvar_12.xy = float2(clipPos_3.xy);
          float3 tmpvar_13;
          tmpvar_13 = mul(unity_CameraInvProjection, tmpvar_12).xyz.xyz;
          orthoPosFar_1.xy = float2(tmpvar_13.xy);
          orthoPosNear_2.z = (-tmpvar_11.z);
          orthoPosFar_1.z = (-tmpvar_13.z);
          out_v.vertex = tmpvar_5;
          out_v.xlv_TEXCOORD0 = tmpvar_4;
          out_v.xlv_TEXCOORD1 = in_v.texcoord1.xyz;
          out_v.xlv_TEXCOORD2 = orthoPosNear_2;
          out_v.xlv_TEXCOORD3 = orthoPosFar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 wpos_2;
          float4 camPos_3;
          float4 clipPos_4;
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xy = float2(in_f.xlv_TEXCOORD0.zw);
          tmpvar_5.z = tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0.xy).x;
          clipPos_4.w = tmpvar_5.w;
          float _tmp_dvx_71 = ((2 * tmpvar_5.xyz) - 1);
          clipPos_4.xyz = float3(_tmp_dvx_71, _tmp_dvx_71, _tmp_dvx_71);
          float4 tmpvar_6;
          tmpvar_6 = mul(unity_CameraInvProjection, clipPos_4);
          camPos_3.w = tmpvar_6.w;
          camPos_3.xyz = float3((tmpvar_6.xyz / tmpvar_6.w));
          camPos_3.z = (-camPos_3.z);
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = float3(camPos_3.xyz);
          wpos_2 = mul(unity_CameraToWorld, tmpvar_7);
          float4 tmpvar_8;
          tmpvar_8 = bool4(camPos_3.zzzz >= _LightSplitsNear);
          float4 tmpvar_9;
          tmpvar_9 = bool4(camPos_3.zzzz < _LightSplitsFar);
          float4 tmpvar_10;
          tmpvar_10 = (float4(tmpvar_8) * float4(tmpvar_9));
          float4 tmpvar_11;
          tmpvar_11.w = 1;
          tmpvar_11.xyz = (((mul(mul(((float4[16])unity_WorldToShadow)[0], wpos_2).xyz, tmpvar_10.x) + mul(mul(((float4[16])unity_WorldToShadow)[1], wpos_2).xyz, tmpvar_10.y)) + mul(mul(((float4[16])unity_WorldToShadow)[2], wpos_2).xyz, tmpvar_10.z)) + mul(mul(((float4[16])unity_WorldToShadow)[3], wpos_2).xyz, tmpvar_10.w)).xyz;
          float shadow_12;
          float2 tmpvar_13;
          tmpvar_13 = _ShadowMapTexture_TexelSize.xy;
          shadow_12 = 0;
          float3 tmpvar_14;
          tmpvar_14.xy = float2((tmpvar_11.xy - _ShadowMapTexture_TexelSize.xy));
          tmpvar_14.z = tmpvar_11.z;
          float4 tmpvar_15;
          tmpvar_15 = tex2D(_ShadowMapTexture, tmpvar_14.xy);
          float tmpvar_16;
          if((tmpvar_15.x<tmpvar_11.z))
          {
              tmpvar_16 = 0;
          }
          else
          {
              tmpvar_16 = 1;
          }
          shadow_12 = tmpvar_16;
          float2 tmpvar_17;
          tmpvar_17.x = 0;
          tmpvar_17.y = (-_ShadowMapTexture_TexelSize.y);
          float3 tmpvar_18;
          tmpvar_18.xy = float2((tmpvar_11.xy + tmpvar_17));
          tmpvar_18.z = tmpvar_11.z;
          float4 tmpvar_19;
          tmpvar_19 = tex2D(_ShadowMapTexture, tmpvar_18.xy);
          float tmpvar_20;
          if((tmpvar_19.x<tmpvar_11.z))
          {
              tmpvar_20 = 0;
          }
          else
          {
              tmpvar_20 = 1;
          }
          shadow_12 = (tmpvar_16 + tmpvar_20);
          float2 tmpvar_21;
          tmpvar_21.x = tmpvar_13.x;
          tmpvar_21.y = (-_ShadowMapTexture_TexelSize.y);
          float3 tmpvar_22;
          tmpvar_22.xy = float2((tmpvar_11.xy + tmpvar_21));
          tmpvar_22.z = tmpvar_11.z;
          float4 tmpvar_23;
          tmpvar_23 = tex2D(_ShadowMapTexture, tmpvar_22.xy);
          float tmpvar_24;
          if((tmpvar_23.x<tmpvar_11.z))
          {
              tmpvar_24 = 0;
          }
          else
          {
              tmpvar_24 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_24);
          float2 tmpvar_25;
          tmpvar_25.y = 0;
          tmpvar_25.x = (-_ShadowMapTexture_TexelSize.x);
          float3 tmpvar_26;
          tmpvar_26.xy = float2((tmpvar_11.xy + tmpvar_25));
          tmpvar_26.z = tmpvar_11.z;
          float4 tmpvar_27;
          tmpvar_27 = tex2D(_ShadowMapTexture, tmpvar_26.xy);
          float tmpvar_28;
          if((tmpvar_27.x<tmpvar_11.z))
          {
              tmpvar_28 = 0;
          }
          else
          {
              tmpvar_28 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_28);
          float4 tmpvar_29;
          tmpvar_29 = tex2D(_ShadowMapTexture, tmpvar_11.xy);
          float tmpvar_30;
          if((tmpvar_29.x<tmpvar_11.z))
          {
              tmpvar_30 = 0;
          }
          else
          {
              tmpvar_30 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_30);
          float2 tmpvar_31;
          tmpvar_31.y = 0;
          tmpvar_31.x = tmpvar_13.x;
          float3 tmpvar_32;
          tmpvar_32.xy = float2((tmpvar_11.xy + tmpvar_31));
          tmpvar_32.z = tmpvar_11.z;
          float4 tmpvar_33;
          tmpvar_33 = tex2D(_ShadowMapTexture, tmpvar_32.xy);
          float tmpvar_34;
          if((tmpvar_33.x<tmpvar_11.z))
          {
              tmpvar_34 = 0;
          }
          else
          {
              tmpvar_34 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_34);
          float2 tmpvar_35;
          tmpvar_35.x = (-_ShadowMapTexture_TexelSize.x);
          tmpvar_35.y = tmpvar_13.y;
          float3 tmpvar_36;
          tmpvar_36.xy = float2((tmpvar_11.xy + tmpvar_35));
          tmpvar_36.z = tmpvar_11.z;
          float4 tmpvar_37;
          tmpvar_37 = tex2D(_ShadowMapTexture, tmpvar_36.xy);
          float tmpvar_38;
          if((tmpvar_37.x<tmpvar_11.z))
          {
              tmpvar_38 = 0;
          }
          else
          {
              tmpvar_38 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_38);
          float2 tmpvar_39;
          tmpvar_39.x = 0;
          tmpvar_39.y = tmpvar_13.y;
          float3 tmpvar_40;
          tmpvar_40.xy = float2((tmpvar_11.xy + tmpvar_39));
          tmpvar_40.z = tmpvar_11.z;
          float4 tmpvar_41;
          tmpvar_41 = tex2D(_ShadowMapTexture, tmpvar_40.xy);
          float tmpvar_42;
          if((tmpvar_41.x<tmpvar_11.z))
          {
              tmpvar_42 = 0;
          }
          else
          {
              tmpvar_42 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_42);
          float3 tmpvar_43;
          tmpvar_43.xy = float2((tmpvar_11.xy + _ShadowMapTexture_TexelSize.xy));
          tmpvar_43.z = tmpvar_11.z;
          float4 tmpvar_44;
          tmpvar_44 = tex2D(_ShadowMapTexture, tmpvar_43.xy);
          float tmpvar_45;
          if((tmpvar_44.x<tmpvar_11.z))
          {
              tmpvar_45 = 0;
          }
          else
          {
              tmpvar_45 = 1;
          }
          shadow_12 = (shadow_12 + tmpvar_45);
          shadow_12 = (shadow_12 / 9);
          float4 tmpvar_46;
          tmpvar_46 = float4(lerp(_LightShadowData.x, 1, shadow_12));
          tmpvar_1 = tmpvar_46;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

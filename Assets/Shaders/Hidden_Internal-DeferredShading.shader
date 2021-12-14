Shader "Hidden/Internal-DeferredShading"
{
  Properties
  {
    _LightTexture0 ("", any) = "" {}
    _LightTextureB0 ("", 2D) = "" {}
    _ShadowMapTexture ("", any) = "" {}
    _SrcBlend ("", float) = 1
    _DstBlend ("", float) = 1
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
      Blend Zero Zero
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
      uniform sampler2D _CameraDepthTexture;
      uniform float4 _LightPos;
      uniform float4 _LightColor;
      uniform sampler2D _LightTextureB0;
      uniform sampler2D unity_NHxRoughness;
      uniform sampler2D _CameraGBufferTexture0;
      uniform sampler2D _CameraGBufferTexture1;
      uniform sampler2D _CameraGBufferTexture2;
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
          float4 gbuffer2_2;
          float4 gbuffer1_3;
          float4 gbuffer0_4;
          float3 tmpvar_5;
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
          tmpvar_11 = (tmpvar_10 - _LightPos.xyz);
          float3 tmpvar_12;
          tmpvar_12 = (-normalize(tmpvar_11));
          lightDir_7 = tmpvar_12;
          float _tmp_dvx_74 = (dot(tmpvar_11, tmpvar_11) * _LightPos.w);
          atten_6 = tex2D(_LightTextureB0, float2(_tmp_dvx_74, _tmp_dvx_74)).w.x;
          tmpvar_5 = (_LightColor.xyz * atten_6);
          float4 tmpvar_13;
          tmpvar_13 = tex2D(_CameraGBufferTexture0, tmpvar_8);
          gbuffer0_4 = tmpvar_13;
          float4 tmpvar_14;
          tmpvar_14 = tex2D(_CameraGBufferTexture1, tmpvar_8);
          gbuffer1_3 = tmpvar_14;
          float4 tmpvar_15;
          tmpvar_15 = tex2D(_CameraGBufferTexture2, tmpvar_8);
          gbuffer2_2 = tmpvar_15;
          float tmpvar_16;
          float3 tmpvar_17;
          tmpvar_16 = gbuffer1_3.w;
          float3 tmpvar_18;
          tmpvar_18 = normalize(((gbuffer2_2.xyz * 2) - 1));
          tmpvar_17 = tmpvar_18;
          float3 viewDir_19;
          viewDir_19 = (-normalize((tmpvar_10 - _WorldSpaceCameraPos)));
          float2 rlPow4AndFresnelTerm_20;
          float tmpvar_21;
          float tmpvar_22;
          tmpvar_22 = clamp(dot(tmpvar_17, lightDir_7), 0, 1);
          tmpvar_21 = tmpvar_22;
          float tmpvar_23;
          float tmpvar_24;
          tmpvar_24 = clamp(dot(tmpvar_17, viewDir_19), 0, 1);
          tmpvar_23 = tmpvar_24;
          float2 tmpvar_25;
          tmpvar_25.x = dot((viewDir_19 - (2 * (dot(tmpvar_17, viewDir_19) * tmpvar_17))), lightDir_7);
          tmpvar_25.y = (1 - tmpvar_23);
          float2 tmpvar_26;
          tmpvar_26 = ((tmpvar_25 * tmpvar_25) * (tmpvar_25 * tmpvar_25));
          rlPow4AndFresnelTerm_20 = tmpvar_26;
          float tmpvar_27;
          tmpvar_27 = rlPow4AndFresnelTerm_20.x;
          float specular_28;
          float smoothness_29;
          smoothness_29 = tmpvar_16;
          float2 tmpvar_30;
          tmpvar_30.x = tmpvar_27;
          tmpvar_30.y = (1 - smoothness_29);
          float tmpvar_31;
          tmpvar_31 = (tex2D(unity_NHxRoughness, tmpvar_30).w * 16).x;
          specular_28 = tmpvar_31;
          float4 tmpvar_32;
          tmpvar_32.w = 1;
          tmpvar_32.xyz = float3(((gbuffer0_4.xyz + (specular_28 * gbuffer1_3.xyz)) * (tmpvar_5 * tmpvar_21)));
          float4 tmpvar_33;
          tmpvar_33 = exp2((-tmpvar_32));
          tmpvar_1 = tmpvar_33;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 255
      } 
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform sampler2D _LightBuffer;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1.w = 1;
          tmpvar_1.xyz = float3(in_v.vertex.xyz);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_1));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1 = (-log2(tex2D(_LightBuffer, in_f.xlv_TEXCOORD0)));
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

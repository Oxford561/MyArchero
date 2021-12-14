Shader "Hidden/Internal-DeferredReflections"
{
  Properties
  {
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
      }
      ZWrite Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
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
      //uniform samplerCUBE unity_SpecCube0;
      //uniform float4 unity_SpecCube0_BoxMax;
      //uniform float4 unity_SpecCube0_BoxMin;
      //uniform float4 unity_SpecCube0_HDR;
      //uniform float4 unity_SpecCube1_ProbePosition;
      uniform sampler2D _CameraDepthTexture;
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
      float4 impl_low_textureCubeLodEXT(samplerCUBE sampler, float3 coord, float lod)
      {
          #if defined( GL_EXT_shader_texture_lod)
          {
              return texCUBE(sampler, float4(coord, lod));
              #else
              return texCUBE(sampler, coord, lod);
              #endif
          }
      
          OUT_Data_Frag frag(v2f in_f)
          {
              float3 tmpvar_1;
              float4 tmpvar_2;
              float4 gbuffer2_3;
              float4 gbuffer1_4;
              float4 gbuffer0_5;
              float2 tmpvar_6;
              tmpvar_6 = (in_f.xlv_TEXCOORD0.xy / in_f.xlv_TEXCOORD0.w);
              float4 tmpvar_7;
              tmpvar_7.w = 1;
              tmpvar_7.xyz = float3(((in_f.xlv_TEXCOORD1 * (_ProjectionParams.z / in_f.xlv_TEXCOORD1.z)) * (1 / ((_ZBufferParams.x * tex2D(_CameraDepthTexture, tmpvar_6).x) + _ZBufferParams.y))));
              float3 tmpvar_8;
              tmpvar_8 = mul(unity_CameraToWorld, tmpvar_7).xyz.xyz;
              float4 tmpvar_9;
              tmpvar_9 = tex2D(_CameraGBufferTexture0, tmpvar_6);
              gbuffer0_5 = tmpvar_9;
              float4 tmpvar_10;
              tmpvar_10 = tex2D(_CameraGBufferTexture1, tmpvar_6);
              gbuffer1_4 = tmpvar_10;
              float4 tmpvar_11;
              tmpvar_11 = tex2D(_CameraGBufferTexture2, tmpvar_6);
              gbuffer2_3 = tmpvar_11;
              float tmpvar_12;
              float3 tmpvar_13;
              tmpvar_12 = gbuffer1_4.w;
              float3 tmpvar_14;
              tmpvar_14 = normalize(((gbuffer2_3.xyz * 2) - 1));
              tmpvar_13 = tmpvar_14;
              float3 tmpvar_15;
              tmpvar_15 = normalize((tmpvar_8 - _WorldSpaceCameraPos));
              tmpvar_1 = (-tmpvar_15);
              tmpvar_2 = unity_SpecCube0_HDR;
              float3 Normal_16;
              Normal_16 = tmpvar_13;
              float tmpvar_17;
              float tmpvar_18;
              float smoothness_19;
              smoothness_19 = tmpvar_12;
              tmpvar_18 = (1 - smoothness_19);
              tmpvar_17 = tmpvar_18;
              float3 I_20;
              I_20 = (-tmpvar_1);
              float4 hdr_21;
              hdr_21 = tmpvar_2;
              float4 tmpvar_22;
              tmpvar_22.xyz = float3((I_20 - (2 * (dot(Normal_16, I_20) * Normal_16))));
              tmpvar_22.w = ((tmpvar_17 * (1.7 - (0.7 * tmpvar_17))) * 6);
              float4 tmpvar_23;
              tmpvar_23 = impl_low_textureCubeLodEXT(unity_SpecCube0, tmpvar_22.xyz, tmpvar_22.w);
              float4 tmpvar_24;
              tmpvar_24 = tmpvar_23;
              float3 viewDir_25;
              viewDir_25 = (-tmpvar_15);
              float2 rlPow4AndFresnelTerm_26;
              float tmpvar_27;
              float tmpvar_28;
              tmpvar_28 = clamp(dot(tmpvar_13, viewDir_25), 0, 1);
              tmpvar_27 = tmpvar_28;
              float2 tmpvar_29;
              tmpvar_29.x = (viewDir_25 - (2 * (dot(tmpvar_13, viewDir_25) * tmpvar_13))).y.x;
              tmpvar_29.y = (1 - tmpvar_27);
              float2 tmpvar_30;
              tmpvar_30 = ((tmpvar_29 * tmpvar_29) * (tmpvar_29 * tmpvar_29));
              rlPow4AndFresnelTerm_26 = tmpvar_30;
              float4 tmpvar_31;
              tmpvar_31.w = 1;
              float _tmp_dvx_75 = ((((hdr_21.x * ((hdr_21.w * (tmpvar_24.w - 1)) + 1)) * tmpvar_24.xyz) * gbuffer0_5.w) * lerp(gbuffer1_4.xyz, float3(clamp((gbuffer1_4.w + (1 - (1 - max(max(gbuffer1_4.x, gbuffer1_4.y), gbuffer1_4.z)))), 0, 1)), rlPow4AndFresnelTerm_26.yyy));
              tmpvar_31.xyz = float3(_tmp_dvx_75, _tmp_dvx_75, _tmp_dvx_75);
              float3 p_32;
              p_32 = tmpvar_8;
              float3 aabbMin_33;
              aabbMin_33 = unity_SpecCube0_BoxMin.xyz;
              float3 aabbMax_34;
              aabbMax_34 = unity_SpecCube0_BoxMax.xyz;
              float3 tmpvar_35;
              tmpvar_35 = max(max((p_32 - aabbMax_34), (aabbMin_33 - p_32)), float3(0, 0, 0));
              float tmpvar_36;
              tmpvar_36 = sqrt(dot(tmpvar_35, tmpvar_35));
              float tmpvar_37;
              float tmpvar_38;
              tmpvar_38 = clamp((1 - (tmpvar_36 / unity_SpecCube1_ProbePosition.w)), 0, 1);
              tmpvar_37 = tmpvar_38;
              float4 tmpvar_39;
              tmpvar_39.xyz = float3(tmpvar_31.xyz);
              tmpvar_39.w = tmpvar_37;
              out_f.color = tmpvar_39;
          }
      
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
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform sampler2D _CameraReflectionsTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
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
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          float4 o_3;
          float4 tmpvar_4;
          tmpvar_4 = (tmpvar_1 * 0.5);
          float2 tmpvar_5;
          tmpvar_5.x = tmpvar_4.x;
          tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
          o_3.xy = float2((tmpvar_5 + tmpvar_4.w));
          o_3.zw = tmpvar_1.zw;
          out_v.xlv_TEXCOORD0 = o_3.xy;
          out_v.vertex = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 c_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_CameraReflectionsTexture, in_f.xlv_TEXCOORD0);
          c_1 = tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.w = 0;
          tmpvar_3.xyz = float3(exp2((-c_1.xyz)));
          out_f.color = tmpvar_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

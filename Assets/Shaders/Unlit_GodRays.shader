Shader "Unlit/GodRays"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZWrite Off
      Blend SrcAlpha One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 xlv_TEXCOORD2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 pos_1;
          float2 tmpvar_2;
          float3 tmpvar_3;
          pos_1.yzw = in_v.vertex.yzw;
          pos_1.x = (in_v.vertex.x * (((1 - in_v.texcoord.y) * 0.4) + 0.6));
          float4 tmpvar_4;
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(pos_1.xyz);
          tmpvar_4 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_5));
          float2 tmpvar_6;
          tmpvar_6.x = ((in_v.texcoord.x * 12) + (_Time.x * 4));
          tmpvar_6.y = (_Time.x * 6);
          float tmpvar_7;
          float3 g_8;
          float3 m_9;
          float4 x12_10;
          float2 tmpvar_11;
          tmpvar_11 = floor((tmpvar_6 + dot(tmpvar_6, float2(0.3660254, 0.3660254))));
          float2 tmpvar_12;
          tmpvar_12 = ((tmpvar_6 - tmpvar_11) + dot(tmpvar_11, float2(0.2113249, 0.2113249)));
          float2 tmpvar_13;
          if((tmpvar_12.x>tmpvar_12.y))
          {
              tmpvar_13 = float2(1, 0);
          }
          else
          {
              tmpvar_13 = float2(0, 1);
          }
          float4 tmpvar_14;
          tmpvar_14 = (tmpvar_12.xyxy + float4(0.2113249, 0.2113249, (-0.5773503), (-0.5773503)));
          x12_10.zw = tmpvar_14.zw;
          x12_10.xy = float2((tmpvar_14.xy - tmpvar_13));
          float2 tmpvar_15;
          tmpvar_15 = (tmpvar_11 - (floor((tmpvar_11 * 0.003460208)) * 289));
          float3 tmpvar_16;
          tmpvar_16.xz = float2(0, 1);
          tmpvar_16.y = tmpvar_13.y;
          float3 x_17;
          x_17 = (tmpvar_15.y + tmpvar_16);
          float3 x_18;
          x_18 = (((x_17 * 34) + 1) * x_17);
          float3 tmpvar_19;
          tmpvar_19.xz = float2(0, 1);
          tmpvar_19.y = tmpvar_13.x;
          float3 x_20;
          x_20 = (((x_18 - (floor((x_18 * 0.003460208)) * 289)) + tmpvar_15.x) + tmpvar_19);
          float3 x_21;
          x_21 = (((x_20 * 34) + 1) * x_20);
          float3 tmpvar_22;
          tmpvar_22.x = dot(tmpvar_12, tmpvar_12);
          tmpvar_22.y = dot(x12_10.xy, x12_10.xy);
          tmpvar_22.z = dot(tmpvar_14.zw, tmpvar_14.zw);
          float3 tmpvar_23;
          tmpvar_23 = max((0.5 - tmpvar_22), float3(0, 0, 0));
          m_9 = (tmpvar_23 * tmpvar_23);
          m_9 = (m_9 * m_9);
          float3 tmpvar_24;
          float _tmp_dvx_47 = ((2 * frac(((x_21 - (floor((x_21 * 0.003460208)) * 289)) * float3(0.02439024, 0.02439024, 0.02439024)))) - 1);
          tmpvar_24 = float3(_tmp_dvx_47, _tmp_dvx_47, _tmp_dvx_47);
          float3 tmpvar_25;
          float _tmp_dvx_48 = (abs(tmpvar_24) - 0.5);
          tmpvar_25 = float3(_tmp_dvx_48, _tmp_dvx_48, _tmp_dvx_48);
          float3 tmpvar_26;
          tmpvar_26 = (tmpvar_24 - floor((tmpvar_24 + 0.5)));
          m_9 = (m_9 * (1.792843 - (0.8537347 * ((tmpvar_26 * tmpvar_26) + (tmpvar_25 * tmpvar_25)))));
          g_8.x = ((tmpvar_26.x * tmpvar_12.x) + (tmpvar_25.x * tmpvar_12.y));
          g_8.yz = ((tmpvar_26.yz * x12_10.xz) + (tmpvar_25.yz * x12_10.yw));
          tmpvar_7 = (130 * dot(m_9, g_8));
          tmpvar_3 = (((float3(1.404, 2.223, 2.34) * ((tmpvar_7 * 0.5) + 0.5)) * in_v.texcoord.y) * (in_v.texcoord.x - 0.1));
          out_v.xlv_TEXCOORD0 = tmpvar_2;
          out_v.vertex = tmpvar_4;
          out_v.xlv_TEXCOORD2 = tmpvar_3;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1.xyz = float3(in_f.xlv_TEXCOORD2);
          tmpvar_1.w = in_f.xlv_TEXCOORD2.z;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

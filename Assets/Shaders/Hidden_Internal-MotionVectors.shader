Shader "Hidden/Internal-MotionVectors"
{
  Properties
  {
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
        "LIGHTMODE" = "MOTIONVECTORS"
      }
      ZWrite Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 _NonJitteredVP;
      uniform float4x4 _PreviousVP;
      uniform float4x4 _PreviousM;
      uniform int _HasLastPositionData;
      uniform float _MotionVectorDepthBias;
      uniform int _ForceNoMotion;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
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
          tmpvar_2 = in_v.texcoord4.xyz;
          float4 tmpvar_3;
          float4 tmpvar_4;
          float4 tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(tmpvar_1.xyz);
          tmpvar_5 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_6));
          tmpvar_4.xyw = tmpvar_5.xyw;
          tmpvar_4.z = (tmpvar_5.z + (_MotionVectorDepthBias * tmpvar_5.w));
          tmpvar_3 = mul(_NonJitteredVP, mul(unity_ObjectToWorld, in_v.vertex));
          float4 tmpvar_7;
          if(_HasLastPositionData)
          {
              float4 tmpvar_8;
              tmpvar_8.w = 1;
              tmpvar_8.xyz = float3(tmpvar_2);
              tmpvar_7 = tmpvar_8;
          }
          else
          {
              tmpvar_7 = tmpvar_1;
          }
          out_v.xlv_TEXCOORD0 = tmpvar_3;
          out_v.xlv_TEXCOORD1 = mul(_PreviousVP, mul(_PreviousM, tmpvar_7));
          out_v.vertex = tmpvar_4;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float2 uvDiff_1;
          float2 tmpvar_2;
          tmpvar_2 = ((((in_f.xlv_TEXCOORD0.xyz / in_f.xlv_TEXCOORD0.w).xy + 1) / 2) - (((in_f.xlv_TEXCOORD1.xyz / in_f.xlv_TEXCOORD1.w).xy + 1) / 2)).xy;
          uvDiff_1 = tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.zw = float2(0, 1);
          tmpvar_3.xy = float2(uvDiff_1);
          float _tmp_dvx_76 = float(_ForceNoMotion);
          out_f.color = (tmpvar_3 * (float4(1, 1, 1, 1) - float4(_tmp_dvx_76, _tmp_dvx_76, _tmp_dvx_76, _tmp_dvx_76)));
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
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      uniform float4x4 _NonJitteredVP;
      uniform float4x4 _PreviousVP;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
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
          out_v.vertex = tmpvar_1;
          out_v.xlv_TEXCOORD0 = o_3.xy;
          out_v.xlv_TEXCOORD1 = in_v.normal;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(((in_f.xlv_TEXCOORD1 * (_ProjectionParams.z / in_f.xlv_TEXCOORD1.z)) * (1 / ((_ZBufferParams.x * tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0).x) + _ZBufferParams.y))));
          float4 tmpvar_3;
          tmpvar_3 = mul(unity_CameraToWorld, tmpvar_2);
          float4 tmpvar_4;
          tmpvar_4 = mul(_PreviousVP, tmpvar_3);
          float4 tmpvar_5;
          tmpvar_5 = mul(_NonJitteredVP, tmpvar_3);
          float2 tmpvar_6;
          tmpvar_6 = (((tmpvar_4.xy / tmpvar_4.w) + 1) / 2);
          float2 tmpvar_7;
          tmpvar_7 = (((tmpvar_5.xy / tmpvar_5.w) + 1) / 2);
          tmpvar_1 = (tmpvar_7 - tmpvar_6);
          float4 tmpvar_8;
          tmpvar_8.zw = float2(0, 1);
          tmpvar_8.xy = float2(tmpvar_1);
          out_f.color = tmpvar_8;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: 
    {
      Tags
      { 
      }
      ZTest Always
      Cull Off
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
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      uniform float4x4 _NonJitteredVP;
      uniform float4x4 _PreviousVP;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
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
          out_v.vertex = tmpvar_1;
          out_v.xlv_TEXCOORD0 = o_3.xy;
          out_v.xlv_TEXCOORD1 = in_v.normal;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1 = tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0);
          float2 tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(((in_f.xlv_TEXCOORD1 * (_ProjectionParams.z / in_f.xlv_TEXCOORD1.z)) * (1 / ((_ZBufferParams.x * tmpvar_1.x) + _ZBufferParams.y))));
          float4 tmpvar_4;
          tmpvar_4 = mul(unity_CameraToWorld, tmpvar_3);
          float4 tmpvar_5;
          tmpvar_5 = mul(_PreviousVP, tmpvar_4);
          float4 tmpvar_6;
          tmpvar_6 = mul(_NonJitteredVP, tmpvar_4);
          float2 tmpvar_7;
          tmpvar_7 = (((tmpvar_5.xy / tmpvar_5.w) + 1) / 2);
          float2 tmpvar_8;
          tmpvar_8 = (((tmpvar_6.xy / tmpvar_6.w) + 1) / 2);
          tmpvar_2 = (tmpvar_8 - tmpvar_7);
          float4 tmpvar_9;
          tmpvar_9.zw = float2(0, 1);
          tmpvar_9.xy = float2(tmpvar_2);
          gl_FragDepthEXT = tmpvar_1.x;
          out_f.color = tmpvar_9;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

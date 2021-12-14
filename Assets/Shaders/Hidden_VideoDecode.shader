Shader "Hidden/VideoDecode"
{
  Properties
  {
    _MainTex ("_MainTex (A)", 2D) = "black" {}
    _SecondTex ("_SecondTex (A)", 2D) = "black" {}
    _ThirdTex ("_ThirdTex (A)", 2D) = "black" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: YCBCR_TO_RGB1
    {
      Name "YCBCR_TO_RGB1"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform sampler2D _ThirdTex;
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
          out_v.xlv_TEXCOORD0 = (TRANSFORM_TEX(in_v.texcoord.xy, _MainTex) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 y_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD0).wwww;
          y_1.w = tmpvar_2.w;
          float4 tmpvar_3;
          tmpvar_3 = tex2D(_SecondTex, in_f.xlv_TEXCOORD0);
          float4 tmpvar_4;
          tmpvar_4 = tex2D(_ThirdTex, in_f.xlv_TEXCOORD0);
          float tmpvar_5;
          tmpvar_5 = (1.15625 * tmpvar_2.w);
          y_1.x = ((tmpvar_5 + (1.59375 * tmpvar_4.w)) - 0.87254);
          y_1.y = (((tmpvar_5 - (0.390625 * tmpvar_3.w)) - (0.8125 * tmpvar_4.w)) + 0.53137);
          y_1.z = ((tmpvar_5 + (1.984375 * tmpvar_3.w)) - 1.06862);
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(y_1.xyz);
          out_f.color = tmpvar_6;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: YCBCRA_TO_RGBAFULL
    {
      Name "YCBCRA_TO_RGBAFULL"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform sampler2D _ThirdTex;
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
          out_v.xlv_TEXCOORD0 = (TRANSFORM_TEX(in_v.texcoord.xy, _MainTex) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 y_1;
          float2 tmpvar_2;
          tmpvar_2.x = (0.5 * in_f.xlv_TEXCOORD0.x);
          tmpvar_2.y = in_f.xlv_TEXCOORD0.y;
          float4 tmpvar_3;
          tmpvar_3 = tex2D(_MainTex, tmpvar_2).wwww;
          y_1.w = tmpvar_3.w;
          float4 tmpvar_4;
          tmpvar_4 = tex2D(_SecondTex, tmpvar_2);
          float4 tmpvar_5;
          tmpvar_5 = tex2D(_ThirdTex, tmpvar_2);
          float2 tmpvar_6;
          tmpvar_6.x = (tmpvar_2.x + 0.5);
          tmpvar_6.y = tmpvar_2.y;
          float tmpvar_7;
          tmpvar_7 = (1.15625 * tmpvar_3.w);
          y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
          y_1.y = (((tmpvar_7 - (0.390625 * tmpvar_4.w)) - (0.8125 * tmpvar_5.w)) + 0.53137);
          y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
          float4 tmpvar_8;
          tmpvar_8.xyz = float3(y_1.xyz);
          tmpvar_8.w = tex2D(_MainTex, tmpvar_6).w.x;
          out_f.color = tmpvar_8;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: YCBCRA_TO_RGBA
    {
      Name "YCBCRA_TO_RGBA"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform sampler2D _ThirdTex;
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
          out_v.xlv_TEXCOORD0 = (TRANSFORM_TEX(in_v.texcoord.xy, _MainTex) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 y_1;
          float2 tmpvar_2;
          tmpvar_2.x = (0.5 * in_f.xlv_TEXCOORD0.x);
          tmpvar_2.y = in_f.xlv_TEXCOORD0.y;
          float4 tmpvar_3;
          tmpvar_3 = tex2D(_MainTex, tmpvar_2).wwww;
          y_1.w = tmpvar_3.w;
          float4 tmpvar_4;
          tmpvar_4 = tex2D(_SecondTex, tmpvar_2);
          float4 tmpvar_5;
          tmpvar_5 = tex2D(_ThirdTex, tmpvar_2);
          float2 tmpvar_6;
          tmpvar_6.x = (tmpvar_2.x + 0.5);
          tmpvar_6.y = tmpvar_2.y;
          float tmpvar_7;
          tmpvar_7 = (1.15625 * tmpvar_3.w);
          y_1.x = ((tmpvar_7 + (1.59375 * tmpvar_5.w)) - 0.87254);
          y_1.y = (((tmpvar_7 - (0.390625 * tmpvar_4.w)) - (0.8125 * tmpvar_5.w)) + 0.53137);
          y_1.z = ((tmpvar_7 + (1.984375 * tmpvar_4.w)) - 1.06862);
          float4 tmpvar_8;
          tmpvar_8.xyz = float3(y_1.xyz);
          tmpvar_8.w = (1.15625 * (tex2D(_MainTex, tmpvar_6).w - 0.062745));
          out_f.color = tmpvar_8;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: COMPOSITE_RGBA_TO_RGBA
    {
      Name "COMPOSITE_RGBA_TO_RGBA"
      Tags
      { 
      }
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform float _AlphaParam;
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
          out_v.xlv_TEXCOORD0 = (TRANSFORM_TEX(in_v.texcoord.xy, _MainTex) + (float(unity_StereoEyeIndex) * _RightEyeUVOffset.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD0);
          float4 tmpvar_3;
          tmpvar_3.xyz = float3(tmpvar_2.xyz);
          tmpvar_3.w = (tmpvar_2.w * _AlphaParam);
          tmpvar_1 = tmpvar_3;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: FLIP_RGBA_TO_RGBA
    {
      Name "FLIP_RGBA_TO_RGBA"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform float _AlphaParam;
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
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (1 - in_v.texcoord.y);
          tmpvar_1 = TRANSFORM_TEX(tmpvar_1, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1 = tex2D(_MainTex, in_f.xlv_TEXCOORD0);
          float4 tmpvar_2;
          tmpvar_2.xyz = float3(tmpvar_1.xyz);
          tmpvar_2.w = (tmpvar_1.w * _AlphaParam);
          float4 color_3;
          color_3 = tmpvar_2;
          out_f.color = color_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 6, name: FLIP_RGBASPLIT_TO_RGBA
    {
      Name "FLIP_RGBASPLIT_TO_RGBA"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
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
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (1 - in_v.texcoord.y);
          tmpvar_1 = TRANSFORM_TEX(tmpvar_1, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float2 tmpvar_1;
          tmpvar_1.x = (0.5 * in_f.xlv_TEXCOORD0.x);
          tmpvar_1.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_2;
          tmpvar_2.x = (tmpvar_1.x + 0.5);
          tmpvar_2.y = tmpvar_1.y;
          float4 tmpvar_3;
          tmpvar_3.xyz = tex2D(_MainTex, tmpvar_1).xyz.xyz;
          tmpvar_3.w = tex2D(_MainTex, tmpvar_2).y.x;
          out_f.color = tmpvar_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 7, name: FLIP_SEMIPLANARYCBCR_TO_RGB1
    {
      Name "FLIP_SEMIPLANARYCBCR_TO_RGB1"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform float4 _MainTex_TexelSize;
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
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (1 - in_v.texcoord.y);
          tmpvar_1 = TRANSFORM_TEX(tmpvar_1, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float tmpvar_1;
          tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
          float tmpvar_2;
          tmpvar_2 = (1 / tmpvar_1);
          int tmpvar_3;
          tmpvar_3 = int(floor(((in_f.xlv_TEXCOORD0.x * tmpvar_1) + 0.5)));
          float tmpvar_4;
          tmpvar_4 = (float(tmpvar_3) / 2);
          float tmpvar_5;
          tmpvar_5 = (frac(abs(tmpvar_4)) * 2);
          float tmpvar_6;
          if((tmpvar_4>=0))
          {
              tmpvar_6 = tmpvar_5;
          }
          else
          {
              tmpvar_6 = (-tmpvar_5);
          }
          int tmpvar_7;
          if((tmpvar_6==0))
          {
              tmpvar_7 = tmpvar_3;
          }
          else
          {
              tmpvar_7 = (tmpvar_3 - 1);
          }
          float2 tmpvar_8;
          tmpvar_8.x = (float(tmpvar_7) * tmpvar_2);
          tmpvar_8.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_9;
          tmpvar_9.x = (float((tmpvar_7 + 1)) * tmpvar_2);
          tmpvar_9.y = in_f.xlv_TEXCOORD0.y;
          float4 tmpvar_10;
          tmpvar_10 = tex2D(_SecondTex, tmpvar_8);
          float4 tmpvar_11;
          tmpvar_11 = tex2D(_SecondTex, tmpvar_9);
          float tmpvar_12;
          tmpvar_12 = (1.15625 * tex2D(_MainTex, in_f.xlv_TEXCOORD0).w);
          float4 tmpvar_13;
          tmpvar_13.w = 1;
          tmpvar_13.x = ((tmpvar_12 + (1.59375 * tmpvar_11.w)) - 0.87254);
          tmpvar_13.y = (((tmpvar_12 - (0.390625 * tmpvar_10.w)) - (0.8125 * tmpvar_11.w)) + 0.53137);
          tmpvar_13.z = ((tmpvar_12 + (1.984375 * tmpvar_10.w)) - 1.06862);
          out_f.color = tmpvar_13;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 8, name: FLIP_SEMIPLANARYCBCRA_TO_RGBA
    {
      Name "FLIP_SEMIPLANARYCBCRA_TO_RGBA"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform float4 _MainTex_TexelSize;
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
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (1 - in_v.texcoord.y);
          tmpvar_1 = TRANSFORM_TEX(tmpvar_1, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float tmpvar_1;
          tmpvar_1 = (_MainTex_TexelSize.z - 0.5);
          float tmpvar_2;
          tmpvar_2 = (2 / tmpvar_1);
          float tmpvar_3;
          tmpvar_3 = (0.5 * in_f.xlv_TEXCOORD0.x);
          int tmpvar_4;
          tmpvar_4 = int(floor(((tmpvar_3 * tmpvar_1) + 0.5)));
          float tmpvar_5;
          tmpvar_5 = (float(tmpvar_4) / 2);
          float tmpvar_6;
          tmpvar_6 = (frac(abs(tmpvar_5)) * 2);
          float tmpvar_7;
          if((tmpvar_5>=0))
          {
              tmpvar_7 = tmpvar_6;
          }
          else
          {
              tmpvar_7 = (-tmpvar_6);
          }
          int tmpvar_8;
          if((tmpvar_7==0))
          {
              tmpvar_8 = tmpvar_4;
          }
          else
          {
              tmpvar_8 = (tmpvar_4 - 1);
          }
          float2 tmpvar_9;
          tmpvar_9.x = (float(tmpvar_8) * tmpvar_2);
          tmpvar_9.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_10;
          tmpvar_10.x = (float((tmpvar_8 + 1)) * tmpvar_2);
          tmpvar_10.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_11;
          tmpvar_11.x = tmpvar_3;
          tmpvar_11.y = in_f.xlv_TEXCOORD0.y;
          float4 tmpvar_12;
          tmpvar_12 = tex2D(_SecondTex, tmpvar_9);
          float4 tmpvar_13;
          tmpvar_13 = tex2D(_SecondTex, tmpvar_10);
          float2 tmpvar_14;
          tmpvar_14.x = (tmpvar_3 + 0.5);
          tmpvar_14.y = in_f.xlv_TEXCOORD0.y;
          float tmpvar_15;
          tmpvar_15 = (1.15625 * tex2D(_MainTex, tmpvar_11).w);
          float4 tmpvar_16;
          tmpvar_16.x = ((tmpvar_15 + (1.59375 * tmpvar_13.w)) - 0.87254);
          tmpvar_16.y = (((tmpvar_15 - (0.390625 * tmpvar_12.w)) - (0.8125 * tmpvar_13.w)) + 0.53137);
          tmpvar_16.z = ((tmpvar_15 + (1.984375 * tmpvar_12.w)) - 1.06862);
          tmpvar_16.w = (1.15625 * (tex2D(_MainTex, tmpvar_14).w - 0.062745));
          out_f.color = tmpvar_16;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 9, name: FLIP_NV12_TO_RGB1
    {
      Name "FLIP_NV12_TO_RGB1"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
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
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (1 - in_v.texcoord.y);
          tmpvar_1 = TRANSFORM_TEX(tmpvar_1, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 result_1;
          float3 yCbCr_2;
          float3 tmpvar_3;
          tmpvar_3.x = (tex2D(_MainTex, in_f.xlv_TEXCOORD0).w - 0.0625).x;
          float4 tmpvar_4;
          tmpvar_4 = tex2D(_SecondTex, in_f.xlv_TEXCOORD0);
          tmpvar_3.y = (tmpvar_4.x - 0.5);
          tmpvar_3.z = (tmpvar_4.y - 0.5);
          yCbCr_2 = tmpvar_3;
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.x = dot(float3(1.1644, 0, 1.7927), yCbCr_2);
          tmpvar_5.y = dot(float3(1.1644, (-0.2133), (-0.5329)), yCbCr_2);
          tmpvar_5.z = dot(float3(1.1644, 2.1124, 0), yCbCr_2);
          result_1 = tmpvar_5;
          out_f.color = result_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 10, name: FLIP_NV12_TO_RGBA
    {
      Name "FLIP_NV12_TO_RGBA"
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
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
          float2 tmpvar_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          tmpvar_1.x = in_v.texcoord.x;
          tmpvar_1.y = (1 - in_v.texcoord.y);
          tmpvar_1 = TRANSFORM_TEX(tmpvar_1, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float tmpvar_1;
          tmpvar_1 = (0.5 * in_f.xlv_TEXCOORD0.x);
          float2 tmpvar_2;
          tmpvar_2.x = tmpvar_1;
          tmpvar_2.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_3;
          tmpvar_3.x = (tmpvar_1 + 0.5);
          tmpvar_3.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_4;
          tmpvar_4.x = tmpvar_1;
          tmpvar_4.y = in_f.xlv_TEXCOORD0.y;
          float2 tmpvar_5;
          tmpvar_5 = tex2D(_SecondTex, tmpvar_4).xy.xy;
          float tmpvar_6;
          tmpvar_6 = (1.15625 * tex2D(_MainTex, tmpvar_2).w);
          float4 tmpvar_7;
          tmpvar_7.x = ((tmpvar_6 + (1.59375 * tmpvar_5.y)) - 0.87254);
          tmpvar_7.y = (((tmpvar_6 - (0.390625 * tmpvar_5.x)) - (0.8125 * tmpvar_5.y)) + 0.53137);
          tmpvar_7.z = ((tmpvar_6 + (1.984375 * tmpvar_5.x)) - 1.06862);
          tmpvar_7.w = (1.15625 * (tex2D(_MainTex, tmpvar_3).w - 0.062745));
          out_f.color = tmpvar_7;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

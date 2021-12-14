Shader "Hidden/FrameDebuggerRenderTargetDisplay"
{
  Properties
  {
    _MainTex ("", any) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "ForceSupported" = "true"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
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
      uniform float4 _Channels;
      uniform float4 _Levels;
      uniform int _UndoOutputSRGB;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
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
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tex_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD0.xy);
          tex_1 = tmpvar_2;
          float4 tmpvar_3;
          float4 col_4;
          col_4 = (tex_1 - _Levels.xxxx);
          col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
          col_4 = (col_4 * _Channels);
          float tmpvar_5;
          tmpvar_5 = dot(_Channels, float4(1, 1, 1, 1));
          if((tmpvar_5==1))
          {
              float _tmp_dvx_59 = dot(col_4, float4(1, 1, 1, 1));
              col_4 = float4(_tmp_dvx_59, _tmp_dvx_59, _tmp_dvx_59, _tmp_dvx_59);
          }
          if(_UndoOutputSRGB)
          {
              float3 tmpvar_6;
              tmpvar_6 = clamp(col_4.xyz, 0, 1);
              col_4.xyz = float3((tmpvar_6 * ((tmpvar_6 * ((tmpvar_6 * 0.305306) + 0.6821711)) + 0.01252288)));
          }
          tmpvar_3 = col_4;
          out_f.color = tmpvar_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
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
      uniform float4 _Channels;
      uniform float4 _Levels;
      uniform int _UndoOutputSRGB;
      uniform samplerCUBE _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
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
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tex_1;
          float4 tmpvar_2;
          tmpvar_2 = texCUBE(_MainTex, in_f.xlv_TEXCOORD0);
          tex_1 = tmpvar_2;
          float4 tmpvar_3;
          float4 col_4;
          col_4 = (tex_1 - _Levels.xxxx);
          col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
          col_4 = (col_4 * _Channels);
          float tmpvar_5;
          tmpvar_5 = dot(_Channels, float4(1, 1, 1, 1));
          if((tmpvar_5==1))
          {
              float _tmp_dvx_60 = dot(col_4, float4(1, 1, 1, 1));
              col_4 = float4(_tmp_dvx_60, _tmp_dvx_60, _tmp_dvx_60, _tmp_dvx_60);
          }
          if(_UndoOutputSRGB)
          {
              float3 tmpvar_6;
              tmpvar_6 = clamp(col_4.xyz, 0, 1);
              col_4.xyz = float3((tmpvar_6 * ((tmpvar_6 * ((tmpvar_6 * 0.305306) + 0.6821711)) + 0.01252288)));
          }
          tmpvar_3 = col_4;
          out_f.color = tmpvar_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
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
      uniform float4 _Channels;
      uniform float4 _Levels;
      uniform int _UndoOutputSRGB;
      uniform UNITY_DECLARE_TEX2DARRAY(_MainTex); 
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xyz = float3(in_v.texcoord.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat10_0;
      float3 u_xlat16_1;
      float3 u_xlat2;
      float3 u_xlat16_2;
      int u_xlatb2;
      float u_xlat16_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = UNITY_SAMPLE_TEX2DARRAY(_MainTex, in_f.texcoord.xyz);
          u_xlat16_0 = (u_xlat10_0 + (-_Levels.xxxx));
          u_xlat16_1.x = ((-_Levels.x) + _Levels.y);
          u_xlat16_0 = (u_xlat16_0 / u_xlat16_1.xxxx);
          u_xlat16_0 = (u_xlat16_0 * _Channels);
          u_xlat16_1.x = dot(u_xlat16_0, float4(1, 1, 1, 1));
          u_xlat16_4 = dot(_Channels, float4(1, 1, 1, 1));
          #ifdef UNITY_ADRENO_ES3
          if((u_xlat16_4==1))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          #else
          if((u_xlat16_4==1))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          #endif
          float _tmp_dvx_61 = int(u_xlatb2);
          u_xlat16_0 = float4(_tmp_dvx_61, _tmp_dvx_61, _tmp_dvx_61, _tmp_dvx_61);
          u_xlat16_1.xyz = float3(u_xlat16_0.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_1.xyz = float3(min(max(u_xlat16_1.xyz, 0), 1));
          #else
          u_xlat16_1.xyz = float3(clamp(u_xlat16_1.xyz, 0, 1));
          #endif
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * float3(0.305306017, 0.305306017, 0.305306017)) + float3(0.682171106, 0.682171106, 0.682171106)));
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * u_xlat16_2.xyz) + float3(0.0125228781, 0.0125228781, 0.0125228781)));
          u_xlat2.xyz = float3((u_xlat16_1.xyz * u_xlat16_2.xyz));
          if((_UndoOutputSRGB!=0))
          {
              out_f.color.xyz = float3(1, 1, 1);
          }
          else
          {
              out_f.color.xyz = float3(0, 0, 0);
          }
          out_f.color.w = u_xlat16_0.w;
          //return u_xlat2.xyz;
          //return u_xlat16_0.xyz;
          //return u_xlat16_1.xxxx;
          //return u_xlat16_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

Shader "Custom/my_distortion"
{
  Properties
  {
    _NoiseTex ("絮乱图", 2D) = "white" {}
    _AreaTex ("区域图(Alpha)：白色为显示区域，透明为不显示区域", 2D) = "white" {}
    _MoveSpeed ("絮乱图移动速度", Range(0, 10)) = 1
    _MoveForce ("絮乱图叠加后移动强度", Range(0, 0.1)) = 0.1
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent+1"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZClip Off
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      // m_ProgramMask = 0
      
    } // end phase
    Pass // ind: 2, name: BASE
    {
      Name "BASE"
      Tags
      { 
        "LIGHTMODE" = "ALWAYS"
        "QUEUE" = "Transparent+1"
        "RenderType" = "Transparent"
      }
      ZWrite Off
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
      uniform float4 _AreaTex_ST;
      //uniform float4 _Time;
      uniform float _MoveSpeed;
      uniform float _MoveForce;
      uniform sampler2D _NoiseTex;
      uniform sampler2D _AreaTex;
      uniform sampler2D _GrabTexture;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
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
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(in_v.vertex.xyz);
          tmpvar_2 = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          tmpvar_1.xy = float2(((tmpvar_2.xy + tmpvar_2.w) * 0.5));
          tmpvar_1.zw = tmpvar_2.zw;
          out_v.vertex = tmpvar_2;
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          out_v.xlv_TEXCOORD1 = TRANSFORM_TEX(in_v.texcoord.xy, _AreaTex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1.zw = in_f.xlv_TEXCOORD0.zw;
          float4 areaCol_2;
          float4 noiseCol_3;
          float4 offsetColor2_4;
          float4 offsetColor1_5;
          float4 tmpvar_6;
          float2 P_7;
          P_7 = (in_f.xlv_TEXCOORD1 + (_Time.xz * _MoveSpeed));
          tmpvar_6 = tex2D(_NoiseTex, P_7);
          offsetColor1_5 = tmpvar_6;
          float4 tmpvar_8;
          float2 P_9;
          P_9 = (in_f.xlv_TEXCOORD1 - (_Time.yx * _MoveSpeed));
          tmpvar_8 = tex2D(_NoiseTex, P_9);
          offsetColor2_4 = tmpvar_8;
          tmpvar_1.xy = float2((in_f.xlv_TEXCOORD0.xy + (((offsetColor1_5.xy + offsetColor2_4.xy) - float2(1, 1)) * float2(_MoveForce, _MoveForce))));
          float4 tmpvar_10;
          tmpvar_10 = tex2D(_GrabTexture, tmpvar_1);
          noiseCol_3.xyz = float3(tmpvar_10.xyz);
          noiseCol_3.w = 1;
          float4 tmpvar_11;
          tmpvar_11 = tex2D(_AreaTex, in_f.xlv_TEXCOORD1);
          areaCol_2 = tmpvar_11;
          out_f.color = (noiseCol_3 * areaCol_2);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Transparent+1"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: BASE
    {
      Name "BASE"
      Tags
      { 
        "QUEUE" = "Transparent+1"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Fog
      { 
        Mode  Off
      } 
      Blend DstColor Zero
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
          float4 xlv_COLOR0 :COLOR0;
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
          tmpvar_2 = clamp(float4(0, 0, 0, 1.1), 0, 1);
          tmpvar_1 = tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(in_v.vertex.xyz);
          out_v.xlv_COLOR0 = tmpvar_1;
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1 = tex2D(_MainTex, in_f.xlv_TEXCOORD0);
          if((tmpvar_1.w<=0.01))
          {
              discard;
          }
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

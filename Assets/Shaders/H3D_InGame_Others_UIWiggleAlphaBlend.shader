Shader "H3D/InGame/Others/UIWiggleAlphaBlend"
{
  Properties
  {
    _MainTex ("主颜色(RGB)", 2D) = "white" {}
    _MaskTex ("掩码纹理(Alpha)", 2D) = "white" {}
    _WiggleTex ("扭动纹理(A)", 2D) = "white" {}
    _WiggleStrength ("扭动强度", Range(0, 10)) = 0.03
    _ScrollX ("主纹理 uv X", float) = 0
    _ScrollY ("主纹理 uv Y", float) = 0
    _WiggleScrollX ("扰动纹理 uv X", float) = 1
    _WiggleScrollY ("扰动纹理 uv Y", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "FORCENOSHADOWCASTING" = "true"
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "FORCENOSHADOWCASTING" = "true"
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 200
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
      uniform float4 _MainTex_ST;
      //uniform float4 _Time;
      uniform float _ScrollX;
      uniform float _ScrollY;
      uniform float _WiggleScrollX;
      uniform float _WiggleScrollY;
      uniform sampler2D _MainTex;
      uniform sampler2D _MaskTex;
      uniform sampler2D _WiggleTex;
      uniform float _WiggleStrength;
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
          tmpvar_1 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float2 tmpvar_2;
          float4 c_3;
          float2 uv_4;
          float2 tmpvar_5;
          tmpvar_5.x = _WiggleScrollX;
          tmpvar_5.y = _WiggleScrollY;
          float2 tmpvar_6;
          tmpvar_6 = frac((tmpvar_5 * _Time.xy));
          uv_4 = (in_f.xlv_TEXCOORD0 + tmpvar_6);
          float4 tmpvar_7;
          tmpvar_7 = tex2D(_WiggleTex, uv_4);
          tmpvar_2.x = (in_f.xlv_TEXCOORD0.x - (tmpvar_7.x * _WiggleStrength));
          tmpvar_2.y = (in_f.xlv_TEXCOORD0.y + (tmpvar_7.z * _WiggleStrength));
          float2 tmpvar_8;
          tmpvar_8.x = _ScrollX;
          tmpvar_8.y = _ScrollY;
          float2 tmpvar_9;
          tmpvar_9 = frac((tmpvar_8 * _Time.xy));
          tmpvar_2 = (tmpvar_2 + tmpvar_9);
          c_3.xyz = tex2D(_MainTex, tmpvar_2).xyz.xyz;
          c_3.w = tex2D(_MaskTex, tmpvar_2).x;
          tmpvar_1 = c_3;
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
      "FORCENOSHADOWCASTING" = "true"
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "FORCENOSHADOWCASTING" = "true"
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZWrite Off
      Cull Off
      Fog
      { 
        Mode  Off
      } 
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
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

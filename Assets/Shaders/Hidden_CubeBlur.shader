Shader "Hidden/CubeBlur"
{
  Properties
  {
    _MainTex ("Main", Cube) = "" {}
    _Texel ("Texel", float) = 0.0078125
    _Level ("Level", float) = 0
    _Scale ("Scale", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
      }
      LOD 200
      ZTest Always
      ZWrite Off
      Cull Off
      Fog
      { 
        Mode  Off
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
      uniform samplerCUBE _MainTex;
      uniform float _Level;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
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
          float4 tmpvar_1;
          tmpvar_1 = in_v.texcoord;
          float4 tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(in_v.vertex.xyz);
          tmpvar_2 = tmpvar_1;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          out_v.xlv_TEXCOORD0 = tmpvar_2;
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
              float4 tmpvar_1;
              float4 tmpvar_2;
              tmpvar_2 = impl_low_textureCubeLodEXT(_MainTex, in_f.xlv_TEXCOORD0.xyz, _Level);
              tmpvar_1 = tmpvar_2;
              out_f.color = tmpvar_1;
          }
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
      }
      LOD 200
      ZTest Always
      ZWrite Off
      Cull Off
      Fog
      { 
        Mode  Off
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
      uniform samplerCUBE _MainTex;
      uniform float _Level;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
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
          float4 tmpvar_1;
          tmpvar_1 = in_v.texcoord;
          float4 tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(in_v.vertex.xyz);
          tmpvar_2 = tmpvar_1;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          out_v.xlv_TEXCOORD0 = tmpvar_2;
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
              float4 tmpvar_1;
              float4 tmpvar_2;
              tmpvar_2 = impl_low_textureCubeLodEXT(_MainTex, in_f.xlv_TEXCOORD0.xyz, _Level);
              tmpvar_1 = tmpvar_2;
              out_f.color = tmpvar_1;
          }
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

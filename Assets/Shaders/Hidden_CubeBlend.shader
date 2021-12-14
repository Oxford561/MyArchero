Shader "Hidden/CubeBlend"
{
  Properties
  {
    [NoScaleOffset] _TexA ("Cubemap", Cube) = "grey" {}
    [NoScaleOffset] _TexB ("Cubemap", Cube) = "grey" {}
    _value ("Value", Range(0, 1)) = 0.5
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Background"
      "RenderType" = "Background"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZTest Always
      ZWrite Off
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
      uniform float4 _TexA_HDR;
      uniform float4 _TexB_HDR;
      uniform samplerCUBE _TexA;
      uniform samplerCUBE _TexB;
      uniform float _Level;
      uniform float _value;
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
              float3 res_1;
              float4 tmpvar_2;
              float4 tmpvar_3;
              tmpvar_3 = impl_low_textureCubeLodEXT(_TexA, in_f.xlv_TEXCOORD0, _Level);
              tmpvar_2 = tmpvar_3;
              float3 tmpvar_4;
              float _tmp_dvx_79 = ((_TexA_HDR.x * ((_TexA_HDR.w * (tmpvar_2.w - 1)) + 1)) * tmpvar_2.xyz);
              tmpvar_4 = float3(_tmp_dvx_79, _tmp_dvx_79, _tmp_dvx_79);
              float4 tmpvar_5;
              float4 tmpvar_6;
              tmpvar_6 = impl_low_textureCubeLodEXT(_TexB, in_f.xlv_TEXCOORD0, _Level);
              tmpvar_5 = tmpvar_6;
              float3 tmpvar_7;
              float _tmp_dvx_80 = ((_TexB_HDR.x * ((_TexB_HDR.w * (tmpvar_5.w - 1)) + 1)) * tmpvar_5.xyz);
              tmpvar_7 = float3(_tmp_dvx_80, _tmp_dvx_80, _tmp_dvx_80);
              float3 tmpvar_8;
              tmpvar_8 = lerp(tmpvar_4, tmpvar_7, float3(_value, _value, _value));
              res_1 = tmpvar_8;
              float4 tmpvar_9;
              tmpvar_9.w = 1;
              tmpvar_9.xyz = float3(res_1);
              out_f.color = tmpvar_9;
          }
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "QUEUE" = "Background"
      "RenderType" = "Background"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZTest Always
      ZWrite Off
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
      uniform float4 _TexA_HDR;
      uniform float4 _TexB_HDR;
      uniform samplerCUBE _TexA;
      uniform samplerCUBE _TexB;
      uniform float _Level;
      uniform float _value;
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
              float3 res_1;
              float4 tmpvar_2;
              float4 tmpvar_3;
              tmpvar_3 = impl_low_textureCubeLodEXT(_TexA, in_f.xlv_TEXCOORD0, _Level);
              tmpvar_2 = tmpvar_3;
              float3 tmpvar_4;
              float _tmp_dvx_81 = ((_TexA_HDR.x * ((_TexA_HDR.w * (tmpvar_2.w - 1)) + 1)) * tmpvar_2.xyz);
              tmpvar_4 = float3(_tmp_dvx_81, _tmp_dvx_81, _tmp_dvx_81);
              float4 tmpvar_5;
              float4 tmpvar_6;
              tmpvar_6 = impl_low_textureCubeLodEXT(_TexB, in_f.xlv_TEXCOORD0, _Level);
              tmpvar_5 = tmpvar_6;
              float3 tmpvar_7;
              float _tmp_dvx_82 = ((_TexB_HDR.x * ((_TexB_HDR.w * (tmpvar_5.w - 1)) + 1)) * tmpvar_5.xyz);
              tmpvar_7 = float3(_tmp_dvx_82, _tmp_dvx_82, _tmp_dvx_82);
              float3 tmpvar_8;
              tmpvar_8 = lerp(tmpvar_4, tmpvar_7, float3(_value, _value, _value));
              res_1 = tmpvar_8;
              float4 tmpvar_9;
              tmpvar_9.w = 1;
              tmpvar_9.xyz = float3(res_1);
              out_f.color = tmpvar_9;
          }
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

Shader "Hidden/Internal-ODSWorldTexture"
{
  Properties
  {
    _MainTex ("", 2D) = "white" {}
    _Cutoff ("", float) = 0.5
    _Color ("", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
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
      struct appdata_t
      {
          float4 vertex :POSITION;
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
          tmpvar_1.w = 1;
          tmpvar_1.xyz = float3(in_v.vertex.xyz);
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = mul(unity_ObjectToWorld, tmpvar_1).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_2);
          out_v.xlv_TEXCOORD0 = mul(unity_ObjectToWorld, in_v.vertex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.xlv_TEXCOORD0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TransparentCutout"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TransparentCutout"
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
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      uniform float4 _Color;
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
          tmpvar_1.w = 1;
          tmpvar_1.xyz = float3(in_v.vertex.xyz);
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = mul(unity_ObjectToWorld, tmpvar_1).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_2);
          out_v.xlv_TEXCOORD0 = mul(unity_ObjectToWorld, in_v.vertex);
          out_v.xlv_TEXCOORD1 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float x_1;
          x_1 = ((tex2D(_MainTex, in_f.xlv_TEXCOORD1).w * _Color.w) - _Cutoff).x;
          if((x_1<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeBark"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeBark"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform float4 _Wind;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float3 normal :NORMAL;
          float4 texcoord1 :TEXCOORD1;
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
          tmpvar_1 = in_v.color;
          float4 tmpvar_2;
          tmpvar_2.w = in_v.vertex.w;
          tmpvar_2.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_3;
          tmpvar_3.xy = float2(tmpvar_1.xy);
          tmpvar_3.zw = in_v.texcoord1.xy;
          float4 pos_4;
          pos_4.w = tmpvar_2.w;
          float3 bend_5;
          float tmpvar_6;
          tmpvar_6 = (dot(conv_mxt4x4_3(unity_ObjectToWorld).xyz, float3(1, 1, 1)) + tmpvar_3.x);
          float2 tmpvar_7;
          float _tmp_dvx_83 = (tmpvar_3.y + tmpvar_6);
          tmpvar_7.x = dot(tmpvar_2.xyz, float3(_tmp_dvx_83, _tmp_dvx_83, _tmp_dvx_83));
          tmpvar_7.y = tmpvar_6;
          float4 tmpvar_8;
          tmpvar_8 = abs(((frac((((frac(((_Time.yy + tmpvar_7).xxyy * float4(1.975, 0.793, 0.375, 0.193))) * 2) - 1) + 0.5)) * 2) - 1));
          float4 tmpvar_9;
          tmpvar_9 = ((tmpvar_8 * tmpvar_8) * (3 - (2 * tmpvar_8)));
          float2 tmpvar_10;
          tmpvar_10 = (tmpvar_9.xz + tmpvar_9.yw);
          float _tmp_dvx_84 = ((tmpvar_3.y * 0.1) * in_v.normal).xz;
          bend_5.xz = float2(_tmp_dvx_84, _tmp_dvx_84);
          bend_5.y = (in_v.texcoord1.y * 0.3);
          pos_4.xyz = float3((tmpvar_2.xyz + (((tmpvar_10.xyx * bend_5) + ((_Wind.xyz * tmpvar_10.y) * in_v.texcoord1.y)) * _Wind.w)));
          pos_4.xyz = float3((pos_4.xyz + (in_v.texcoord1.x * _Wind.xyz)));
          float4 tmpvar_11;
          tmpvar_11.w = 1;
          tmpvar_11.xyz = float3(lerp((pos_4.xyz - ((dot(_SquashPlaneNormal.xyz, pos_4.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_4.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          tmpvar_2 = tmpvar_11;
          float4 tmpvar_12;
          tmpvar_12.w = 1;
          tmpvar_12.xyz = float3(tmpvar_11.xyz);
          float4 tmpvar_13;
          tmpvar_13.w = 1;
          tmpvar_13.xyz = mul(unity_ObjectToWorld, tmpvar_12).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_13);
          out_v.xlv_TEXCOORD0 = mul(unity_ObjectToWorld, tmpvar_11);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.xlv_TEXCOORD0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeLeaf"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeLeaf"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform float4 _Wind;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      struct appdata_t
      {
          float4 tangent :TANGENT;
          float4 vertex :POSITION;
          float4 color :COLOR;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4x4 tmpvar_2;
          conv_mxt4x4_0(tmpvar_2).x = conv_mxt4x4_0(m_1).x;
          conv_mxt4x4_0(tmpvar_2).y = conv_mxt4x4_1(m_1).x;
          conv_mxt4x4_0(tmpvar_2).z = conv_mxt4x4_2(m_1).x;
          conv_mxt4x4_0(tmpvar_2).w = conv_mxt4x4_3(m_1).x;
          conv_mxt4x4_1(tmpvar_2).x = conv_mxt4x4_0(m_1).y.x;
          conv_mxt4x4_1(tmpvar_2).y = conv_mxt4x4_1(m_1).y.x;
          conv_mxt4x4_1(tmpvar_2).z = conv_mxt4x4_2(m_1).y.x;
          conv_mxt4x4_1(tmpvar_2).w = conv_mxt4x4_3(m_1).y.x;
          conv_mxt4x4_2(tmpvar_2).x = conv_mxt4x4_0(m_1).z.x;
          conv_mxt4x4_2(tmpvar_2).y = conv_mxt4x4_1(m_1).z.x;
          conv_mxt4x4_2(tmpvar_2).z = conv_mxt4x4_2(m_1).z.x;
          conv_mxt4x4_2(tmpvar_2).w = conv_mxt4x4_3(m_1).z.x;
          conv_mxt4x4_3(tmpvar_2).x = conv_mxt4x4_0(m_1).w.x;
          conv_mxt4x4_3(tmpvar_2).y = conv_mxt4x4_1(m_1).w.x;
          conv_mxt4x4_3(tmpvar_2).z = conv_mxt4x4_2(m_1).w.x;
          conv_mxt4x4_3(tmpvar_2).w = conv_mxt4x4_3(m_1).w.x;
          float3 tmpvar_3;
          tmpvar_3 = in_v.normal;
          float4 tmpvar_4;
          tmpvar_4 = in_v.color;
          float4 tmpvar_5;
          float4 pos_6;
          float tmpvar_7;
          tmpvar_7 = (1 - abs(in_v.tangent.w));
          float4 tmpvar_8;
          tmpvar_8.w = 0;
          tmpvar_8.xyz = float3(tmpvar_3);
          float4 tmpvar_9;
          tmpvar_9.zw = float2(0, 0);
          tmpvar_9.xy = float2(tmpvar_3.xy);
          pos_6 = (in_v.vertex + (mul(tmpvar_9, tmpvar_2) * tmpvar_7));
          tmpvar_5.w = pos_6.w;
          tmpvar_5.xyz = float3((pos_6.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_10;
          tmpvar_10.xy = float2(tmpvar_4.xy);
          tmpvar_10.zw = in_v.texcoord1.xy;
          float4 pos_11;
          pos_11.w = tmpvar_5.w;
          float3 bend_12;
          float tmpvar_13;
          tmpvar_13 = (dot(conv_mxt4x4_3(unity_ObjectToWorld).xyz, float3(1, 1, 1)) + tmpvar_10.x);
          float2 tmpvar_14;
          float _tmp_dvx_85 = (tmpvar_10.y + tmpvar_13);
          tmpvar_14.x = dot(tmpvar_5.xyz, float3(_tmp_dvx_85, _tmp_dvx_85, _tmp_dvx_85));
          tmpvar_14.y = tmpvar_13;
          float4 tmpvar_15;
          tmpvar_15 = abs(((frac((((frac(((_Time.yy + tmpvar_14).xxyy * float4(1.975, 0.793, 0.375, 0.193))) * 2) - 1) + 0.5)) * 2) - 1));
          float4 tmpvar_16;
          tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3 - (2 * tmpvar_15)));
          float2 tmpvar_17;
          tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
          float _tmp_dvx_86 = ((tmpvar_10.y * 0.1) * lerp(in_v.normal, normalize(mul(tmpvar_8, tmpvar_2)).xyz, float3(tmpvar_7, tmpvar_7, tmpvar_7))).xz;
          bend_12.xz = float2(_tmp_dvx_86, _tmp_dvx_86);
          bend_12.y = (in_v.texcoord1.y * 0.3);
          pos_11.xyz = float3((tmpvar_5.xyz + (((tmpvar_17.xyx * bend_12) + ((_Wind.xyz * tmpvar_17.y) * in_v.texcoord1.y)) * _Wind.w)));
          pos_11.xyz = float3((pos_11.xyz + (in_v.texcoord1.x * _Wind.xyz)));
          float4 tmpvar_18;
          tmpvar_18.w = 1;
          tmpvar_18.xyz = float3(lerp((pos_11.xyz - ((dot(_SquashPlaneNormal.xyz, pos_11.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_11.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          tmpvar_5 = tmpvar_18;
          float4 tmpvar_19;
          tmpvar_19.w = 1;
          tmpvar_19.xyz = float3(tmpvar_18.xyz);
          float4 tmpvar_20;
          tmpvar_20.w = 1;
          tmpvar_20.xyz = mul(unity_ObjectToWorld, tmpvar_19).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_20);
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, tmpvar_18);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float alpha_1;
          float tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD0).w.x;
          alpha_1 = tmpvar_2;
          float x_3;
          x_3 = (alpha_1 - _Cutoff);
          if((x_3<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "RenderType" = "TreeOpaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeOpaque"
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
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
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
          tmpvar_1 = in_v.color;
          float4 pos_2;
          pos_2.w = in_v.vertex.w;
          float alpha_3;
          alpha_3 = tmpvar_1.w;
          pos_2.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_4;
          tmpvar_4.w = 0;
          tmpvar_4.xyz = float3(pos_2.xyz);
          pos_2.xyz = float3(lerp(pos_2.xyz, mul(_TerrainEngineBendTree, tmpvar_4).xyz, float3(alpha_3, alpha_3, alpha_3)));
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(lerp((pos_2.xyz - ((dot(_SquashPlaneNormal.xyz, pos_2.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_2.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          pos_2 = tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(tmpvar_5.xyz);
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = mul(unity_ObjectToWorld, tmpvar_6).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_7);
          out_v.xlv_TEXCOORD0 = mul(unity_ObjectToWorld, tmpvar_5);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.xlv_TEXCOORD0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "RenderType" = "TreeTransparentCutout"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeTransparentCutout"
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
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
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
          tmpvar_1 = in_v.color;
          float4 pos_2;
          pos_2.w = in_v.vertex.w;
          float alpha_3;
          alpha_3 = tmpvar_1.w;
          pos_2.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_4;
          tmpvar_4.w = 0;
          tmpvar_4.xyz = float3(pos_2.xyz);
          pos_2.xyz = float3(lerp(pos_2.xyz, mul(_TerrainEngineBendTree, tmpvar_4).xyz, float3(alpha_3, alpha_3, alpha_3)));
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(lerp((pos_2.xyz - ((dot(_SquashPlaneNormal.xyz, pos_2.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_2.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          pos_2 = tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(tmpvar_5.xyz);
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = mul(unity_ObjectToWorld, tmpvar_6).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_7);
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, tmpvar_5);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float alpha_1;
          float tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD0).w.x;
          alpha_1 = tmpvar_2;
          float x_3;
          x_3 = (alpha_1 - _Cutoff);
          if((x_3<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeTransparentCutout"
      }
      Cull Front
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
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
          tmpvar_1 = in_v.color;
          float4 pos_2;
          pos_2.w = in_v.vertex.w;
          float alpha_3;
          alpha_3 = tmpvar_1.w;
          pos_2.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_4;
          tmpvar_4.w = 0;
          tmpvar_4.xyz = float3(pos_2.xyz);
          pos_2.xyz = float3(lerp(pos_2.xyz, mul(_TerrainEngineBendTree, tmpvar_4).xyz, float3(alpha_3, alpha_3, alpha_3)));
          float4 tmpvar_5;
          tmpvar_5.w = 1;
          tmpvar_5.xyz = float3(lerp((pos_2.xyz - ((dot(_SquashPlaneNormal.xyz, pos_2.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_2.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          pos_2 = tmpvar_5;
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(tmpvar_5.xyz);
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = mul(unity_ObjectToWorld, tmpvar_6).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_7);
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, tmpvar_5);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float x_1;
          x_1 = (tex2D(_MainTex, in_f.xlv_TEXCOORD0).w - _Cutoff).x;
          if((x_1<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeBillboard"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeBillboard"
      }
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
      uniform float3 _TreeBillboardCameraRight;
      uniform float4 _TreeBillboardCameraUp;
      uniform float4 _TreeBillboardCameraFront;
      uniform float4 _TreeBillboardCameraPos;
      uniform float4 _TreeBillboardDistances;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
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
          tmpvar_1 = in_v.texcoord;
          float2 tmpvar_2;
          float4 pos_3;
          pos_3 = in_v.vertex;
          float2 offset_4;
          offset_4 = in_v.texcoord1.xy;
          float offsetz_5;
          offsetz_5 = tmpvar_1.y;
          float3 tmpvar_6;
          tmpvar_6 = (in_v.vertex.xyz - _TreeBillboardCameraPos.xyz);
          float tmpvar_7;
          tmpvar_7 = dot(tmpvar_6, tmpvar_6);
          if((tmpvar_7>_TreeBillboardDistances.x))
          {
              offsetz_5 = 0;
              offset_4 = float2(0, 0);
          }
          pos_3.xyz = float3((in_v.vertex.xyz + (_TreeBillboardCameraRight * offset_4.x)));
          pos_3.xyz = float3((pos_3.xyz + (_TreeBillboardCameraUp.xyz * lerp(offset_4.y, offsetz_5, _TreeBillboardCameraPos.w))));
          pos_3.xyz = float3((pos_3.xyz + ((_TreeBillboardCameraFront.xyz * abs(offset_4.x)) * _TreeBillboardCameraUp.w)));
          float4 tmpvar_8;
          tmpvar_8.w = 1;
          tmpvar_8.xyz = float3(pos_3.xyz);
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = mul(unity_ObjectToWorld, tmpvar_8).xyz.xyz;
          tmpvar_2.x = tmpvar_1.x;
          if(float((in_v.texcoord.y>0)))
          {
              tmpvar_2.y = 1;
          }
          else
          {
              tmpvar_2.y = 0;
          }
          out_v.vertex = mul(unity_MatrixVP, tmpvar_9);
          out_v.xlv_TEXCOORD0 = tmpvar_2;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, pos_3);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float x_1;
          x_1 = (tex2D(_MainTex, in_f.xlv_TEXCOORD0).w - 0.001).x;
          if((x_1<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "GrassBillboard"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "GrassBillboard"
      }
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
      uniform float4 _WavingTint;
      uniform float4 _WaveAndDistance;
      uniform float4 _CameraPosition;
      uniform float3 _CameraRight;
      uniform float3 _CameraUp;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      struct appdata_t
      {
          float4 tangent :TANGENT;
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
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
          tmpvar_1 = in_v.texcoord;
          float4 tmpvar_2;
          tmpvar_2 = in_v.color;
          float4 pos_3;
          pos_3 = in_v.vertex;
          float2 offset_4;
          offset_4 = in_v.tangent.xy;
          float3 tmpvar_5;
          tmpvar_5 = (in_v.vertex.xyz - _CameraPosition.xyz);
          float tmpvar_6;
          tmpvar_6 = dot(tmpvar_5, tmpvar_5);
          if((tmpvar_6>_WaveAndDistance.w))
          {
              offset_4 = float2(0, 0);
          }
          pos_3.xyz = float3((in_v.vertex.xyz + (offset_4.x * _CameraRight)));
          pos_3.xyz = float3((pos_3.xyz + (offset_4.y * _CameraUp)));
          float4 vertex_7;
          vertex_7.yw = pos_3.yw;
          float4 color_8;
          color_8.xyz = float3(tmpvar_2.xyz);
          float3 waveColor_9;
          float3 waveMove_10;
          float4 s_11;
          float4 waves_12;
          waves_12 = (pos_3.x * (float4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
          waves_12 = (waves_12 + (pos_3.z * (float4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
          waves_12 = (waves_12 + (_WaveAndDistance.x * float4(1.2, 2, 1.6, 4.8)));
          float4 tmpvar_13;
          tmpvar_13 = frac(waves_12);
          waves_12 = tmpvar_13;
          float4 val_14;
          float4 s_15;
          val_14 = ((tmpvar_13 * 6.408849) - 3.141593);
          float4 tmpvar_16;
          tmpvar_16 = (val_14 * val_14);
          float4 tmpvar_17;
          tmpvar_17 = (tmpvar_16 * val_14);
          float4 tmpvar_18;
          tmpvar_18 = (tmpvar_17 * tmpvar_16);
          s_15 = (((val_14 + (tmpvar_17 * (-0.1616162))) + (tmpvar_18 * 0.0083333)) + ((tmpvar_18 * tmpvar_16) * (-0.00019841)));
          s_11 = (s_15 * s_15);
          s_11 = (s_11 * s_11);
          float tmpvar_19;
          tmpvar_19 = (dot(s_11, float4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
          s_11 = (s_11 * in_v.tangent.y);
          waveMove_10.y = 0;
          waveMove_10.x = dot(s_11, float4(0.024, 0.04, (-0.12), 0.096));
          waveMove_10.z = dot(s_11, float4(0.006, 0.02, (-0.02), 0.1));
          vertex_7.xz = (pos_3.xz - (waveMove_10.xz * _WaveAndDistance.z));
          float3 tmpvar_20;
          tmpvar_20 = lerp(float3(0.5, 0.5, 0.5), _WavingTint.xyz, float3(tmpvar_19, tmpvar_19, tmpvar_19));
          waveColor_9 = tmpvar_20;
          float3 tmpvar_21;
          tmpvar_21 = (vertex_7.xyz - _CameraPosition.xyz);
          float tmpvar_22;
          tmpvar_22 = clamp(((2 * (_WaveAndDistance.w - dot(tmpvar_21, tmpvar_21))) * _CameraPosition.w), 0, 1);
          color_8.w = tmpvar_22;
          float4 tmpvar_23;
          float _tmp_dvx_87 = ((2 * waveColor_9) * in_v.color.xyz);
          tmpvar_23.xyz = float3(_tmp_dvx_87, _tmp_dvx_87, _tmp_dvx_87);
          tmpvar_23.w = color_8.w;
          float4 tmpvar_24;
          tmpvar_24.w = 1;
          tmpvar_24.xyz = float3(vertex_7.xyz);
          float4 tmpvar_25;
          tmpvar_25.w = 1;
          tmpvar_25.xyz = mul(unity_ObjectToWorld, tmpvar_24).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_25);
          out_v.xlv_COLOR = tmpvar_23;
          out_v.xlv_TEXCOORD0 = tmpvar_1.xy;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, vertex_7);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float x_1;
          x_1 = ((tex2D(_MainTex, in_f.xlv_TEXCOORD0).w * in_f.xlv_COLOR.w) - _Cutoff).x;
          if((x_1<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Grass"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Grass"
      }
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
      uniform float4 _WavingTint;
      uniform float4 _WaveAndDistance;
      uniform float4 _CameraPosition;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 vertex_1;
          vertex_1.yw = in_v.vertex.yw;
          float4 color_2;
          color_2.xyz = float3(in_v.color.xyz);
          float3 waveColor_3;
          float3 waveMove_4;
          float4 s_5;
          float4 waves_6;
          waves_6 = (in_v.vertex.x * (float4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
          waves_6 = (waves_6 + (in_v.vertex.z * (float4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
          waves_6 = (waves_6 + (_WaveAndDistance.x * float4(1.2, 2, 1.6, 4.8)));
          float4 tmpvar_7;
          tmpvar_7 = frac(waves_6);
          waves_6 = tmpvar_7;
          float4 val_8;
          float4 s_9;
          val_8 = ((tmpvar_7 * 6.408849) - 3.141593);
          float4 tmpvar_10;
          tmpvar_10 = (val_8 * val_8);
          float4 tmpvar_11;
          tmpvar_11 = (tmpvar_10 * val_8);
          float4 tmpvar_12;
          tmpvar_12 = (tmpvar_11 * tmpvar_10);
          s_9 = (((val_8 + (tmpvar_11 * (-0.1616162))) + (tmpvar_12 * 0.0083333)) + ((tmpvar_12 * tmpvar_10) * (-0.00019841)));
          s_5 = (s_9 * s_9);
          s_5 = (s_5 * s_5);
          float tmpvar_13;
          tmpvar_13 = (dot(s_5, float4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
          s_5 = (s_5 * (in_v.color.w * _WaveAndDistance.z));
          waveMove_4.y = 0;
          waveMove_4.x = dot(s_5, float4(0.024, 0.04, (-0.12), 0.096));
          waveMove_4.z = dot(s_5, float4(0.006, 0.02, (-0.02), 0.1));
          vertex_1.xz = (in_v.vertex.xz - (waveMove_4.xz * _WaveAndDistance.z));
          float3 tmpvar_14;
          tmpvar_14 = lerp(float3(0.5, 0.5, 0.5), _WavingTint.xyz, float3(tmpvar_13, tmpvar_13, tmpvar_13));
          waveColor_3 = tmpvar_14;
          float3 tmpvar_15;
          tmpvar_15 = (vertex_1.xyz - _CameraPosition.xyz);
          float tmpvar_16;
          tmpvar_16 = clamp(((2 * (_WaveAndDistance.w - dot(tmpvar_15, tmpvar_15))) * _CameraPosition.w), 0, 1);
          color_2.w = tmpvar_16;
          float4 tmpvar_17;
          float _tmp_dvx_88 = ((2 * waveColor_3) * in_v.color.xyz);
          tmpvar_17.xyz = float3(_tmp_dvx_88, _tmp_dvx_88, _tmp_dvx_88);
          tmpvar_17.w = color_2.w;
          float4 tmpvar_18;
          tmpvar_18.w = 1;
          tmpvar_18.xyz = float3(vertex_1.xyz);
          float4 tmpvar_19;
          tmpvar_19.w = 1;
          tmpvar_19.xyz = mul(unity_ObjectToWorld, tmpvar_18).xyz.xyz;
          out_v.vertex = mul(unity_MatrixVP, tmpvar_19);
          out_v.xlv_COLOR = tmpvar_17;
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, vertex_1);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float x_1;
          x_1 = ((tex2D(_MainTex, in_f.xlv_TEXCOORD0).w * in_f.xlv_COLOR.w) - _Cutoff).x;
          if((x_1<0))
          {
              discard;
          }
          out_f.color = in_f.xlv_TEXCOORD1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

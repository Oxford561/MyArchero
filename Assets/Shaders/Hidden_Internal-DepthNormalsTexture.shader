Shader "Hidden/Internal-DepthNormalsTexture"
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.vertex;
          float4 tmpvar_6;
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = float3(tmpvar_5.xyz);
          float3x3 tmpvar_8;
          tmpvar_8[0] = tmpvar_2.xyz;
          tmpvar_8[1] = tmpvar_3.xyz;
          tmpvar_8[2] = tmpvar_4.xyz;
          tmpvar_6.xyz = float3(normalize(mul(tmpvar_8, in_v.normal)));
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = float3(tmpvar_5.xyz);
          tmpvar_6.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_9)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_7));
          out_v.xlv_TEXCOORD0 = tmpvar_6;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 enc_2;
          float2 enc_3;
          enc_3 = (in_f.xlv_TEXCOORD0.xy / (in_f.xlv_TEXCOORD0.z + 1));
          enc_3 = (enc_3 / 1.7777);
          enc_3 = ((enc_3 * 0.5) + 0.5);
          enc_2.xy = float2(enc_3);
          float2 enc_4;
          float2 tmpvar_5;
          tmpvar_5 = frac((float2(1, 255) * in_f.xlv_TEXCOORD0.w));
          enc_4.y = tmpvar_5.y;
          enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
          enc_2.zw = enc_4;
          tmpvar_1 = enc_2;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform float _Cutoff;
      uniform float4 _Color;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.vertex;
          float4 tmpvar_6;
          float4 tmpvar_7;
          tmpvar_7.w = 1;
          tmpvar_7.xyz = float3(tmpvar_5.xyz);
          float3x3 tmpvar_8;
          tmpvar_8[0] = tmpvar_2.xyz;
          tmpvar_8[1] = tmpvar_3.xyz;
          tmpvar_8[2] = tmpvar_4.xyz;
          tmpvar_6.xyz = float3(normalize(mul(tmpvar_8, in_v.normal)));
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = float3(tmpvar_5.xyz);
          tmpvar_6.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_9)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_7));
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.xlv_TEXCOORD1 = tmpvar_6;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float x_2;
          x_2 = ((tex2D(_MainTex, in_f.xlv_TEXCOORD0).w * _Color.w) - _Cutoff).x;
          if((x_2<0))
          {
              discard;
          }
          float4 enc_3;
          float2 enc_4;
          enc_4 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_4 = (enc_4 / 1.7777);
          enc_4 = ((enc_4 * 0.5) + 0.5);
          enc_3.xy = float2(enc_4);
          float2 enc_5;
          float2 tmpvar_6;
          tmpvar_6 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_5.y = tmpvar_6.y;
          enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
          enc_3.zw = enc_5;
          tmpvar_1 = enc_3;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
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
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.color;
          float4 tmpvar_6;
          float4 tmpvar_7;
          tmpvar_7.w = in_v.vertex.w;
          tmpvar_7.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_8;
          tmpvar_8.xy = float2(tmpvar_5.xy);
          tmpvar_8.zw = in_v.texcoord1.xy;
          float4 pos_9;
          pos_9.w = tmpvar_7.w;
          float3 bend_10;
          float tmpvar_11;
          tmpvar_11 = (dot(conv_mxt4x4_3(unity_ObjectToWorld).xyz, float3(1, 1, 1)) + tmpvar_8.x);
          float2 tmpvar_12;
          float _tmp_dvx_62 = (tmpvar_8.y + tmpvar_11);
          tmpvar_12.x = dot(tmpvar_7.xyz, float3(_tmp_dvx_62, _tmp_dvx_62, _tmp_dvx_62));
          tmpvar_12.y = tmpvar_11;
          float4 tmpvar_13;
          tmpvar_13 = abs(((frac((((frac(((_Time.yy + tmpvar_12).xxyy * float4(1.975, 0.793, 0.375, 0.193))) * 2) - 1) + 0.5)) * 2) - 1));
          float4 tmpvar_14;
          tmpvar_14 = ((tmpvar_13 * tmpvar_13) * (3 - (2 * tmpvar_13)));
          float2 tmpvar_15;
          tmpvar_15 = (tmpvar_14.xz + tmpvar_14.yw);
          float _tmp_dvx_63 = ((tmpvar_8.y * 0.1) * in_v.normal).xz;
          bend_10.xz = float2(_tmp_dvx_63, _tmp_dvx_63);
          bend_10.y = (in_v.texcoord1.y * 0.3);
          pos_9.xyz = float3((tmpvar_7.xyz + (((tmpvar_15.xyx * bend_10) + ((_Wind.xyz * tmpvar_15.y) * in_v.texcoord1.y)) * _Wind.w)));
          pos_9.xyz = float3((pos_9.xyz + (in_v.texcoord1.x * _Wind.xyz)));
          float4 tmpvar_16;
          tmpvar_16.w = 1;
          tmpvar_16.xyz = float3(lerp((pos_9.xyz - ((dot(_SquashPlaneNormal.xyz, pos_9.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_9.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          tmpvar_7 = tmpvar_16;
          float4 tmpvar_17;
          tmpvar_17.w = 1;
          tmpvar_17.xyz = float3(tmpvar_16.xyz);
          float3x3 tmpvar_18;
          tmpvar_18[0] = tmpvar_2.xyz;
          tmpvar_18[1] = tmpvar_3.xyz;
          tmpvar_18[2] = tmpvar_4.xyz;
          tmpvar_6.xyz = float3(normalize(mul(tmpvar_18, normalize(in_v.normal))));
          float4 tmpvar_19;
          tmpvar_19.w = 1;
          tmpvar_19.xyz = float3(tmpvar_16.xyz);
          tmpvar_6.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_19)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_17));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_6;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 enc_2;
          float2 enc_3;
          enc_3 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_3 = (enc_3 / 1.7777);
          enc_3 = ((enc_3 * 0.5) + 0.5);
          enc_2.xy = float2(enc_3);
          float2 enc_4;
          float2 tmpvar_5;
          tmpvar_5 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_4.y = tmpvar_5.y;
          enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
          enc_2.zw = enc_4;
          tmpvar_1 = enc_2;
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
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
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
          float4 tmpvar_6;
          float4 pos_7;
          float tmpvar_8;
          tmpvar_8 = (1 - abs(in_v.tangent.w));
          float4 tmpvar_9;
          tmpvar_9.w = 0;
          tmpvar_9.xyz = float3(tmpvar_3);
          float4 tmpvar_10;
          tmpvar_10.zw = float2(0, 0);
          tmpvar_10.xy = float2(tmpvar_3.xy);
          pos_7 = (in_v.vertex + (mul(tmpvar_10, tmpvar_2) * tmpvar_8));
          float3 tmpvar_11;
          tmpvar_11 = lerp(in_v.normal, normalize(mul(tmpvar_9, tmpvar_2)).xyz, float3(tmpvar_8, tmpvar_8, tmpvar_8));
          tmpvar_6.w = pos_7.w;
          tmpvar_6.xyz = float3((pos_7.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_12;
          tmpvar_12.xy = float2(tmpvar_4.xy);
          tmpvar_12.zw = in_v.texcoord1.xy;
          float4 pos_13;
          pos_13.w = tmpvar_6.w;
          float3 bend_14;
          float tmpvar_15;
          tmpvar_15 = (dot(conv_mxt4x4_3(unity_ObjectToWorld).xyz, float3(1, 1, 1)) + tmpvar_12.x);
          float2 tmpvar_16;
          float _tmp_dvx_64 = (tmpvar_12.y + tmpvar_15);
          tmpvar_16.x = dot(tmpvar_6.xyz, float3(_tmp_dvx_64, _tmp_dvx_64, _tmp_dvx_64));
          tmpvar_16.y = tmpvar_15;
          float4 tmpvar_17;
          tmpvar_17 = abs(((frac((((frac(((_Time.yy + tmpvar_16).xxyy * float4(1.975, 0.793, 0.375, 0.193))) * 2) - 1) + 0.5)) * 2) - 1));
          float4 tmpvar_18;
          tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3 - (2 * tmpvar_17)));
          float2 tmpvar_19;
          tmpvar_19 = (tmpvar_18.xz + tmpvar_18.yw);
          float _tmp_dvx_65 = ((tmpvar_12.y * 0.1) * tmpvar_11).xz;
          bend_14.xz = float2(_tmp_dvx_65, _tmp_dvx_65);
          bend_14.y = (in_v.texcoord1.y * 0.3);
          pos_13.xyz = float3((tmpvar_6.xyz + (((tmpvar_19.xyx * bend_14) + ((_Wind.xyz * tmpvar_19.y) * in_v.texcoord1.y)) * _Wind.w)));
          pos_13.xyz = float3((pos_13.xyz + (in_v.texcoord1.x * _Wind.xyz)));
          float4 tmpvar_20;
          tmpvar_20.w = 1;
          tmpvar_20.xyz = float3(lerp((pos_13.xyz - ((dot(_SquashPlaneNormal.xyz, pos_13.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_13.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          tmpvar_6 = tmpvar_20;
          float4 tmpvar_21;
          tmpvar_21.w = 1;
          tmpvar_21.xyz = float3(tmpvar_20.xyz);
          float3x3 tmpvar_22;
          tmpvar_22[0] = conv_mxt4x4_0(tmpvar_2).xyz;
          tmpvar_22[1] = conv_mxt4x4_1(tmpvar_2).xyz;
          tmpvar_22[2] = conv_mxt4x4_2(tmpvar_2).xyz;
          tmpvar_5.xyz = float3(normalize(mul(tmpvar_22, normalize(tmpvar_11))));
          float4 tmpvar_23;
          tmpvar_23.w = 1;
          tmpvar_23.xyz = float3(tmpvar_20.xyz);
          tmpvar_5.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_23)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_21));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_5;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float alpha_2;
          float tmpvar_3;
          tmpvar_3 = tex2D(_MainTex, in_f.xlv_TEXCOORD0).w.x;
          alpha_2 = tmpvar_3;
          float x_4;
          x_4 = (alpha_2 - _Cutoff);
          if((x_4<0))
          {
              discard;
          }
          float4 enc_5;
          float2 enc_6;
          enc_6 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_6 = (enc_6 / 1.7777);
          enc_6 = ((enc_6 * 0.5) + 0.5);
          enc_5.xy = float2(enc_6);
          float2 enc_7;
          float2 tmpvar_8;
          tmpvar_8 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_7.y = tmpvar_8.y;
          enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
          enc_5.zw = enc_7;
          tmpvar_1 = enc_5;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.color;
          float4 tmpvar_6;
          float4 pos_7;
          pos_7.w = in_v.vertex.w;
          float alpha_8;
          alpha_8 = tmpvar_5.w;
          pos_7.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_9;
          tmpvar_9.w = 0;
          tmpvar_9.xyz = float3(pos_7.xyz);
          pos_7.xyz = float3(lerp(pos_7.xyz, mul(_TerrainEngineBendTree, tmpvar_9).xyz, float3(alpha_8, alpha_8, alpha_8)));
          float4 tmpvar_10;
          tmpvar_10.w = 1;
          tmpvar_10.xyz = float3(lerp((pos_7.xyz - ((dot(_SquashPlaneNormal.xyz, pos_7.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_7.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          pos_7 = tmpvar_10;
          float4 tmpvar_11;
          tmpvar_11.w = 1;
          tmpvar_11.xyz = float3(tmpvar_10.xyz);
          float3x3 tmpvar_12;
          tmpvar_12[0] = tmpvar_2.xyz;
          tmpvar_12[1] = tmpvar_3.xyz;
          tmpvar_12[2] = tmpvar_4.xyz;
          tmpvar_6.xyz = float3(normalize(mul(tmpvar_12, in_v.normal)));
          float4 tmpvar_13;
          tmpvar_13.w = 1;
          tmpvar_13.xyz = float3(tmpvar_10.xyz);
          tmpvar_6.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_13)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_11));
          out_v.xlv_TEXCOORD0 = tmpvar_6;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 enc_2;
          float2 enc_3;
          enc_3 = (in_f.xlv_TEXCOORD0.xy / (in_f.xlv_TEXCOORD0.z + 1));
          enc_3 = (enc_3 / 1.7777);
          enc_3 = ((enc_3 * 0.5) + 0.5);
          enc_2.xy = float2(enc_3);
          float2 enc_4;
          float2 tmpvar_5;
          tmpvar_5 = frac((float2(1, 255) * in_f.xlv_TEXCOORD0.w));
          enc_4.y = tmpvar_5.y;
          enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
          enc_2.zw = enc_4;
          tmpvar_1 = enc_2;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
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
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.color;
          float4 tmpvar_6;
          float4 pos_7;
          pos_7.w = in_v.vertex.w;
          float alpha_8;
          alpha_8 = tmpvar_5.w;
          pos_7.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_9;
          tmpvar_9.w = 0;
          tmpvar_9.xyz = float3(pos_7.xyz);
          pos_7.xyz = float3(lerp(pos_7.xyz, mul(_TerrainEngineBendTree, tmpvar_9).xyz, float3(alpha_8, alpha_8, alpha_8)));
          float4 tmpvar_10;
          tmpvar_10.w = 1;
          tmpvar_10.xyz = float3(lerp((pos_7.xyz - ((dot(_SquashPlaneNormal.xyz, pos_7.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_7.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          pos_7 = tmpvar_10;
          float4 tmpvar_11;
          tmpvar_11.w = 1;
          tmpvar_11.xyz = float3(tmpvar_10.xyz);
          float3x3 tmpvar_12;
          tmpvar_12[0] = tmpvar_2.xyz;
          tmpvar_12[1] = tmpvar_3.xyz;
          tmpvar_12[2] = tmpvar_4.xyz;
          tmpvar_6.xyz = float3(normalize(mul(tmpvar_12, in_v.normal)));
          float4 tmpvar_13;
          tmpvar_13.w = 1;
          tmpvar_13.xyz = float3(tmpvar_10.xyz);
          tmpvar_6.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_13)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_11));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_6;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float alpha_2;
          float tmpvar_3;
          tmpvar_3 = tex2D(_MainTex, in_f.xlv_TEXCOORD0).w.x;
          alpha_2 = tmpvar_3;
          float x_4;
          x_4 = (alpha_2 - _Cutoff);
          if((x_4<0))
          {
              discard;
          }
          float4 enc_5;
          float2 enc_6;
          enc_6 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_6 = (enc_6 / 1.7777);
          enc_6 = ((enc_6 * 0.5) + 0.5);
          enc_5.xy = float2(enc_6);
          float2 enc_7;
          float2 tmpvar_8;
          tmpvar_8 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_7.y = tmpvar_8.y;
          enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
          enc_5.zw = enc_7;
          tmpvar_1 = enc_5;
          out_f.color = tmpvar_1;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
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
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.color;
          float4 tmpvar_6;
          float4 pos_7;
          pos_7.w = in_v.vertex.w;
          float alpha_8;
          alpha_8 = tmpvar_5.w;
          pos_7.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          float4 tmpvar_9;
          tmpvar_9.w = 0;
          tmpvar_9.xyz = float3(pos_7.xyz);
          pos_7.xyz = float3(lerp(pos_7.xyz, mul(_TerrainEngineBendTree, tmpvar_9).xyz, float3(alpha_8, alpha_8, alpha_8)));
          float4 tmpvar_10;
          tmpvar_10.w = 1;
          tmpvar_10.xyz = float3(lerp((pos_7.xyz - ((dot(_SquashPlaneNormal.xyz, pos_7.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_7.xyz, float3(_SquashAmount, _SquashAmount, _SquashAmount)));
          pos_7 = tmpvar_10;
          float4 tmpvar_11;
          tmpvar_11.w = 1;
          tmpvar_11.xyz = float3(tmpvar_10.xyz);
          float3x3 tmpvar_12;
          tmpvar_12[0] = tmpvar_2.xyz;
          tmpvar_12[1] = tmpvar_3.xyz;
          tmpvar_12[2] = tmpvar_4.xyz;
          tmpvar_6.xyz = float3((-normalize(mul(tmpvar_12, in_v.normal))));
          float4 tmpvar_13;
          tmpvar_13.w = 1;
          tmpvar_13.xyz = float3(tmpvar_10.xyz);
          tmpvar_6.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_13)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_11));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_6;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float x_2;
          x_2 = (tex2D(_MainTex, in_f.xlv_TEXCOORD0).w - _Cutoff).x;
          if((x_2<0))
          {
              discard;
          }
          float4 enc_3;
          float2 enc_4;
          enc_4 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_4 = (enc_4 / 1.7777);
          enc_4 = ((enc_4 * 0.5) + 0.5);
          enc_3.xy = float2(enc_4);
          float2 enc_5;
          float2 tmpvar_6;
          tmpvar_6 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_5.y = tmpvar_6.y;
          enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
          enc_3.zw = enc_5;
          tmpvar_1 = enc_3;
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
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
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
          float4 tmpvar_3;
          float4 pos_4;
          pos_4 = in_v.vertex;
          float2 offset_5;
          offset_5 = in_v.texcoord1.xy;
          float offsetz_6;
          offsetz_6 = tmpvar_1.y;
          float3 tmpvar_7;
          tmpvar_7 = (in_v.vertex.xyz - _TreeBillboardCameraPos.xyz);
          float tmpvar_8;
          tmpvar_8 = dot(tmpvar_7, tmpvar_7);
          if((tmpvar_8>_TreeBillboardDistances.x))
          {
              offsetz_6 = 0;
              offset_5 = float2(0, 0);
          }
          pos_4.xyz = float3((in_v.vertex.xyz + (_TreeBillboardCameraRight * offset_5.x)));
          pos_4.xyz = float3((pos_4.xyz + (_TreeBillboardCameraUp.xyz * lerp(offset_5.y, offsetz_6, _TreeBillboardCameraPos.w))));
          pos_4.xyz = float3((pos_4.xyz + ((_TreeBillboardCameraFront.xyz * abs(offset_5.x)) * _TreeBillboardCameraUp.w)));
          float4 tmpvar_9;
          tmpvar_9.w = 1;
          tmpvar_9.xyz = float3(pos_4.xyz);
          tmpvar_2.x = tmpvar_1.x;
          if(float((in_v.texcoord.y>0)))
          {
              tmpvar_2.y = 1;
          }
          else
          {
              tmpvar_2.y = 0;
          }
          tmpvar_3.xyz = float3(0, 0, 1);
          float4 tmpvar_10;
          tmpvar_10.w = 1;
          tmpvar_10.xyz = float3(pos_4.xyz);
          tmpvar_3.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_10)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_9));
          out_v.xlv_TEXCOORD0 = tmpvar_2;
          out_v.xlv_TEXCOORD1 = tmpvar_3;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float x_2;
          x_2 = (tex2D(_MainTex, in_f.xlv_TEXCOORD0).w - 0.001).x;
          if((x_2<0))
          {
              discard;
          }
          float4 enc_3;
          float2 enc_4;
          enc_4 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_4 = (enc_4 / 1.7777);
          enc_4 = ((enc_4 * 0.5) + 0.5);
          enc_3.xy = float2(enc_4);
          float2 enc_5;
          float2 tmpvar_6;
          tmpvar_6 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_5.y = tmpvar_6.y;
          enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
          enc_3.zw = enc_5;
          tmpvar_1 = enc_3;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
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
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          tmpvar_5 = in_v.texcoord;
          float4 tmpvar_6;
          tmpvar_6 = in_v.color;
          float4 tmpvar_7;
          float4 pos_8;
          pos_8 = in_v.vertex;
          float2 offset_9;
          offset_9 = in_v.tangent.xy;
          float3 tmpvar_10;
          tmpvar_10 = (in_v.vertex.xyz - _CameraPosition.xyz);
          float tmpvar_11;
          tmpvar_11 = dot(tmpvar_10, tmpvar_10);
          if((tmpvar_11>_WaveAndDistance.w))
          {
              offset_9 = float2(0, 0);
          }
          pos_8.xyz = float3((in_v.vertex.xyz + (offset_9.x * _CameraRight)));
          pos_8.xyz = float3((pos_8.xyz + (offset_9.y * _CameraUp)));
          float4 vertex_12;
          vertex_12.yw = pos_8.yw;
          float4 color_13;
          color_13.xyz = float3(tmpvar_6.xyz);
          float3 waveColor_14;
          float3 waveMove_15;
          float4 s_16;
          float4 waves_17;
          waves_17 = (pos_8.x * (float4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
          waves_17 = (waves_17 + (pos_8.z * (float4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
          waves_17 = (waves_17 + (_WaveAndDistance.x * float4(1.2, 2, 1.6, 4.8)));
          float4 tmpvar_18;
          tmpvar_18 = frac(waves_17);
          waves_17 = tmpvar_18;
          float4 val_19;
          float4 s_20;
          val_19 = ((tmpvar_18 * 6.408849) - 3.141593);
          float4 tmpvar_21;
          tmpvar_21 = (val_19 * val_19);
          float4 tmpvar_22;
          tmpvar_22 = (tmpvar_21 * val_19);
          float4 tmpvar_23;
          tmpvar_23 = (tmpvar_22 * tmpvar_21);
          s_20 = (((val_19 + (tmpvar_22 * (-0.1616162))) + (tmpvar_23 * 0.0083333)) + ((tmpvar_23 * tmpvar_21) * (-0.00019841)));
          s_16 = (s_20 * s_20);
          s_16 = (s_16 * s_16);
          float tmpvar_24;
          tmpvar_24 = (dot(s_16, float4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
          s_16 = (s_16 * in_v.tangent.y);
          waveMove_15.y = 0;
          waveMove_15.x = dot(s_16, float4(0.024, 0.04, (-0.12), 0.096));
          waveMove_15.z = dot(s_16, float4(0.006, 0.02, (-0.02), 0.1));
          vertex_12.xz = (pos_8.xz - (waveMove_15.xz * _WaveAndDistance.z));
          float3 tmpvar_25;
          tmpvar_25 = lerp(float3(0.5, 0.5, 0.5), _WavingTint.xyz, float3(tmpvar_24, tmpvar_24, tmpvar_24));
          waveColor_14 = tmpvar_25;
          float3 tmpvar_26;
          tmpvar_26 = (vertex_12.xyz - _CameraPosition.xyz);
          float tmpvar_27;
          tmpvar_27 = clamp(((2 * (_WaveAndDistance.w - dot(tmpvar_26, tmpvar_26))) * _CameraPosition.w), 0, 1);
          color_13.w = tmpvar_27;
          float4 tmpvar_28;
          float _tmp_dvx_66 = ((2 * waveColor_14) * in_v.color.xyz);
          tmpvar_28.xyz = float3(_tmp_dvx_66, _tmp_dvx_66, _tmp_dvx_66);
          tmpvar_28.w = color_13.w;
          float4 tmpvar_29;
          tmpvar_29.w = 1;
          tmpvar_29.xyz = float3(vertex_12.xyz);
          float3x3 tmpvar_30;
          tmpvar_30[0] = tmpvar_2.xyz;
          tmpvar_30[1] = tmpvar_3.xyz;
          tmpvar_30[2] = tmpvar_4.xyz;
          tmpvar_7.xyz = float3(normalize(mul(tmpvar_30, in_v.normal)));
          float4 tmpvar_31;
          tmpvar_31.w = 1;
          tmpvar_31.xyz = float3(vertex_12.xyz);
          tmpvar_7.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_31)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_29));
          out_v.xlv_COLOR = tmpvar_28;
          out_v.xlv_TEXCOORD0 = tmpvar_5.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_7;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float x_2;
          x_2 = ((tex2D(_MainTex, in_f.xlv_TEXCOORD0).w * in_f.xlv_COLOR.w) - _Cutoff).x;
          if((x_2<0))
          {
              discard;
          }
          float4 enc_3;
          float2 enc_4;
          enc_4 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_4 = (enc_4 / 1.7777);
          enc_4 = ((enc_4 * 0.5) + 0.5);
          enc_3.xy = float2(enc_4);
          float2 enc_5;
          float2 tmpvar_6;
          tmpvar_6 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_5.y = tmpvar_6.y;
          enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
          enc_3.zw = enc_5;
          tmpvar_1 = enc_3;
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
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
          float3 normal :NORMAL;
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
          float4x4 m_1;
          m_1 = mul(unity_WorldToObject, unity_MatrixInvV);
          float4 tmpvar_2;
          float4 tmpvar_3;
          float4 tmpvar_4;
          tmpvar_2.x = conv_mxt4x4_0(m_1).x;
          tmpvar_2.y = conv_mxt4x4_1(m_1).x;
          tmpvar_2.z = conv_mxt4x4_2(m_1).x;
          tmpvar_2.w = conv_mxt4x4_3(m_1).x;
          tmpvar_3.x = conv_mxt4x4_0(m_1).y.x;
          tmpvar_3.y = conv_mxt4x4_1(m_1).y.x;
          tmpvar_3.z = conv_mxt4x4_2(m_1).y.x;
          tmpvar_3.w = conv_mxt4x4_3(m_1).y.x;
          tmpvar_4.x = conv_mxt4x4_0(m_1).z.x;
          tmpvar_4.y = conv_mxt4x4_1(m_1).z.x;
          tmpvar_4.z = conv_mxt4x4_2(m_1).z.x;
          tmpvar_4.w = conv_mxt4x4_3(m_1).z.x;
          float4 tmpvar_5;
          float4 vertex_6;
          vertex_6.yw = in_v.vertex.yw;
          float4 color_7;
          color_7.xyz = float3(in_v.color.xyz);
          float3 waveColor_8;
          float3 waveMove_9;
          float4 s_10;
          float4 waves_11;
          waves_11 = (in_v.vertex.x * (float4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
          waves_11 = (waves_11 + (in_v.vertex.z * (float4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
          waves_11 = (waves_11 + (_WaveAndDistance.x * float4(1.2, 2, 1.6, 4.8)));
          float4 tmpvar_12;
          tmpvar_12 = frac(waves_11);
          waves_11 = tmpvar_12;
          float4 val_13;
          float4 s_14;
          val_13 = ((tmpvar_12 * 6.408849) - 3.141593);
          float4 tmpvar_15;
          tmpvar_15 = (val_13 * val_13);
          float4 tmpvar_16;
          tmpvar_16 = (tmpvar_15 * val_13);
          float4 tmpvar_17;
          tmpvar_17 = (tmpvar_16 * tmpvar_15);
          s_14 = (((val_13 + (tmpvar_16 * (-0.1616162))) + (tmpvar_17 * 0.0083333)) + ((tmpvar_17 * tmpvar_15) * (-0.00019841)));
          s_10 = (s_14 * s_14);
          s_10 = (s_10 * s_10);
          float tmpvar_18;
          tmpvar_18 = (dot(s_10, float4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
          s_10 = (s_10 * (in_v.color.w * _WaveAndDistance.z));
          waveMove_9.y = 0;
          waveMove_9.x = dot(s_10, float4(0.024, 0.04, (-0.12), 0.096));
          waveMove_9.z = dot(s_10, float4(0.006, 0.02, (-0.02), 0.1));
          vertex_6.xz = (in_v.vertex.xz - (waveMove_9.xz * _WaveAndDistance.z));
          float3 tmpvar_19;
          tmpvar_19 = lerp(float3(0.5, 0.5, 0.5), _WavingTint.xyz, float3(tmpvar_18, tmpvar_18, tmpvar_18));
          waveColor_8 = tmpvar_19;
          float3 tmpvar_20;
          tmpvar_20 = (vertex_6.xyz - _CameraPosition.xyz);
          float tmpvar_21;
          tmpvar_21 = clamp(((2 * (_WaveAndDistance.w - dot(tmpvar_20, tmpvar_20))) * _CameraPosition.w), 0, 1);
          color_7.w = tmpvar_21;
          float4 tmpvar_22;
          float _tmp_dvx_67 = ((2 * waveColor_8) * in_v.color.xyz);
          tmpvar_22.xyz = float3(_tmp_dvx_67, _tmp_dvx_67, _tmp_dvx_67);
          tmpvar_22.w = color_7.w;
          float4 tmpvar_23;
          tmpvar_23.w = 1;
          tmpvar_23.xyz = float3(vertex_6.xyz);
          float3x3 tmpvar_24;
          tmpvar_24[0] = tmpvar_2.xyz;
          tmpvar_24[1] = tmpvar_3.xyz;
          tmpvar_24[2] = tmpvar_4.xyz;
          tmpvar_5.xyz = float3(normalize(mul(tmpvar_24, in_v.normal)));
          float4 tmpvar_25;
          tmpvar_25.w = 1;
          tmpvar_25.xyz = float3(vertex_6.xyz);
          tmpvar_5.w = (-(mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_25)).z * _ProjectionParams.w)).x;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_23));
          out_v.xlv_COLOR = tmpvar_22;
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          out_v.xlv_TEXCOORD1 = tmpvar_5;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float x_2;
          x_2 = ((tex2D(_MainTex, in_f.xlv_TEXCOORD0).w * in_f.xlv_COLOR.w) - _Cutoff).x;
          if((x_2<0))
          {
              discard;
          }
          float4 enc_3;
          float2 enc_4;
          enc_4 = (in_f.xlv_TEXCOORD1.xy / (in_f.xlv_TEXCOORD1.z + 1));
          enc_4 = (enc_4 / 1.7777);
          enc_4 = ((enc_4 * 0.5) + 0.5);
          enc_3.xy = float2(enc_4);
          float2 enc_5;
          float2 tmpvar_6;
          tmpvar_6 = frac((float2(1, 255) * in_f.xlv_TEXCOORD1.w));
          enc_5.y = tmpvar_6.y;
          enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
          enc_3.zw = enc_5;
          tmpvar_1 = enc_3;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

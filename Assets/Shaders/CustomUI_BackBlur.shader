Shader "CustomUI/BackBlur"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    _Color ("Main Color", Color) = (1,1,1,1)
    _Size ("Size", Range(0, 20)) = 1
  }
  SubShader
  {
    Tags
    { 
      "CanUseSpriteAtlas" = "true"
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
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
    Pass // ind: 2, name: BACKBLURHOR
    {
      Name "BACKBLURHOR"
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "ALWAYS"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
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
      uniform sampler2D _GrabTexture;
      uniform float4 _GrabTexture_TexelSize;
      uniform float _Size;
      uniform float4 _Color;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_COLOR :COLOR;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_COLOR :COLOR;
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
          out_v.xlv_COLOR = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float decayFactor_1;
          float4 col5_2;
          float4 sum_3;
          sum_3 = float4(0, 0, 0, 0);
          float4 tmpvar_4;
          float kernelx_5;
          kernelx_5 = (-4);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_5 = 0;
          }
          float4 tmpvar_6;
          tmpvar_6.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_5) * _Size));
          tmpvar_6.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_7;
          tmpvar_7 = tex2D(_GrabTexture, tmpvar_6);
          tmpvar_4 = (tmpvar_7 * 0.05);
          sum_3 = tmpvar_4;
          float4 tmpvar_8;
          float kernelx_9;
          kernelx_9 = (-3);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_9 = 0;
          }
          float4 tmpvar_10;
          tmpvar_10.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_9) * _Size));
          tmpvar_10.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_11;
          tmpvar_11 = tex2D(_GrabTexture, tmpvar_10);
          tmpvar_8 = (tmpvar_11 * 0.09);
          sum_3 = (tmpvar_4 + tmpvar_8);
          float4 tmpvar_12;
          float kernelx_13;
          kernelx_13 = (-2);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_13 = 0;
          }
          float4 tmpvar_14;
          tmpvar_14.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_13) * _Size));
          tmpvar_14.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_15;
          tmpvar_15 = tex2D(_GrabTexture, tmpvar_14);
          tmpvar_12 = (tmpvar_15 * 0.12);
          sum_3 = (sum_3 + tmpvar_12);
          float4 tmpvar_16;
          float kernelx_17;
          kernelx_17 = (-1);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_17 = 0;
          }
          float4 tmpvar_18;
          tmpvar_18.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_17) * _Size));
          tmpvar_18.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_19;
          tmpvar_19 = tex2D(_GrabTexture, tmpvar_18);
          tmpvar_16 = (tmpvar_19 * 0.15);
          sum_3 = (sum_3 + tmpvar_16);
          float4 tmpvar_20;
          float kernelx_21;
          kernelx_21 = 0;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_21 = 0;
          }
          float4 tmpvar_22;
          tmpvar_22.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_21) * _Size));
          tmpvar_22.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_23;
          tmpvar_23 = tex2D(_GrabTexture, tmpvar_22);
          tmpvar_20 = (tmpvar_23 * 0.18);
          sum_3 = (sum_3 + tmpvar_20);
          float4 tmpvar_24;
          float kernelx_25;
          kernelx_25 = 1;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_25 = 0;
          }
          float4 tmpvar_26;
          tmpvar_26.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_25) * _Size));
          tmpvar_26.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_27;
          tmpvar_27 = tex2D(_GrabTexture, tmpvar_26);
          tmpvar_24 = (tmpvar_27 * 0.15);
          sum_3 = (sum_3 + tmpvar_24);
          float4 tmpvar_28;
          float kernelx_29;
          kernelx_29 = 2;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_29 = 0;
          }
          float4 tmpvar_30;
          tmpvar_30.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_29) * _Size));
          tmpvar_30.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_31;
          tmpvar_31 = tex2D(_GrabTexture, tmpvar_30);
          tmpvar_28 = (tmpvar_31 * 0.12);
          sum_3 = (sum_3 + tmpvar_28);
          float4 tmpvar_32;
          float kernelx_33;
          kernelx_33 = 3;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_33 = 0;
          }
          float4 tmpvar_34;
          tmpvar_34.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_33) * _Size));
          tmpvar_34.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_35;
          tmpvar_35 = tex2D(_GrabTexture, tmpvar_34);
          tmpvar_32 = (tmpvar_35 * 0.09);
          sum_3 = (sum_3 + tmpvar_32);
          float4 tmpvar_36;
          float kernelx_37;
          kernelx_37 = 4;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernelx_37 = 0;
          }
          float4 tmpvar_38;
          tmpvar_38.x = (in_f.xlv_TEXCOORD0.x + ((_GrabTexture_TexelSize.x * kernelx_37) * _Size));
          tmpvar_38.yzw = in_f.xlv_TEXCOORD0.yzw;
          float4 tmpvar_39;
          tmpvar_39 = tex2D(_GrabTexture, tmpvar_38);
          tmpvar_36 = (tmpvar_39 * 0.05);
          sum_3 = (sum_3 + tmpvar_36);
          float4 tmpvar_40;
          tmpvar_40 = tex2D(_GrabTexture, in_f.xlv_TEXCOORD0);
          col5_2 = tmpvar_40;
          decayFactor_1 = 1;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              decayFactor_1 = 0;
          }
          float4 tmpvar_41;
          tmpvar_41 = lerp(col5_2, sum_3, float4(decayFactor_1, decayFactor_1, decayFactor_1, decayFactor_1));
          sum_3 = ((tmpvar_41 * in_f.xlv_COLOR) * _Color);
          out_f.color = sum_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: 
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
    Pass // ind: 4, name: BACKBLURVER
    {
      Name "BACKBLURVER"
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "ALWAYS"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
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
      uniform sampler2D _GrabTexture;
      uniform float4 _GrabTexture_TexelSize;
      uniform float _Size;
      uniform float4 _Color;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_COLOR :COLOR;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_COLOR :COLOR;
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
          out_v.xlv_COLOR = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float decayFactor_1;
          float4 col5_2;
          float4 sum_3;
          sum_3 = float4(0, 0, 0, 0);
          float4 tmpvar_4;
          float kernely_5;
          kernely_5 = (-4);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_5 = 0;
          }
          float4 tmpvar_6;
          tmpvar_6.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_6.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_5) * _Size));
          tmpvar_6.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_7;
          tmpvar_7 = tex2D(_GrabTexture, tmpvar_6);
          tmpvar_4 = (tmpvar_7 * 0.05);
          sum_3 = tmpvar_4;
          float4 tmpvar_8;
          float kernely_9;
          kernely_9 = (-3);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_9 = 0;
          }
          float4 tmpvar_10;
          tmpvar_10.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_10.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_9) * _Size));
          tmpvar_10.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_11;
          tmpvar_11 = tex2D(_GrabTexture, tmpvar_10);
          tmpvar_8 = (tmpvar_11 * 0.09);
          sum_3 = (tmpvar_4 + tmpvar_8);
          float4 tmpvar_12;
          float kernely_13;
          kernely_13 = (-2);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_13 = 0;
          }
          float4 tmpvar_14;
          tmpvar_14.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_14.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_13) * _Size));
          tmpvar_14.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_15;
          tmpvar_15 = tex2D(_GrabTexture, tmpvar_14);
          tmpvar_12 = (tmpvar_15 * 0.12);
          sum_3 = (sum_3 + tmpvar_12);
          float4 tmpvar_16;
          float kernely_17;
          kernely_17 = (-1);
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_17 = 0;
          }
          float4 tmpvar_18;
          tmpvar_18.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_18.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_17) * _Size));
          tmpvar_18.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_19;
          tmpvar_19 = tex2D(_GrabTexture, tmpvar_18);
          tmpvar_16 = (tmpvar_19 * 0.15);
          sum_3 = (sum_3 + tmpvar_16);
          float4 tmpvar_20;
          float kernely_21;
          kernely_21 = 0;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_21 = 0;
          }
          float4 tmpvar_22;
          tmpvar_22.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_22.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_21) * _Size));
          tmpvar_22.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_23;
          tmpvar_23 = tex2D(_GrabTexture, tmpvar_22);
          tmpvar_20 = (tmpvar_23 * 0.18);
          sum_3 = (sum_3 + tmpvar_20);
          float4 tmpvar_24;
          float kernely_25;
          kernely_25 = 1;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_25 = 0;
          }
          float4 tmpvar_26;
          tmpvar_26.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_26.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_25) * _Size));
          tmpvar_26.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_27;
          tmpvar_27 = tex2D(_GrabTexture, tmpvar_26);
          tmpvar_24 = (tmpvar_27 * 0.15);
          sum_3 = (sum_3 + tmpvar_24);
          float4 tmpvar_28;
          float kernely_29;
          kernely_29 = 2;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_29 = 0;
          }
          float4 tmpvar_30;
          tmpvar_30.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_30.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_29) * _Size));
          tmpvar_30.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_31;
          tmpvar_31 = tex2D(_GrabTexture, tmpvar_30);
          tmpvar_28 = (tmpvar_31 * 0.12);
          sum_3 = (sum_3 + tmpvar_28);
          float4 tmpvar_32;
          float kernely_33;
          kernely_33 = 3;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_33 = 0;
          }
          float4 tmpvar_34;
          tmpvar_34.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_34.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_33) * _Size));
          tmpvar_34.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_35;
          tmpvar_35 = tex2D(_GrabTexture, tmpvar_34);
          tmpvar_32 = (tmpvar_35 * 0.09);
          sum_3 = (sum_3 + tmpvar_32);
          float4 tmpvar_36;
          float kernely_37;
          kernely_37 = 4;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              kernely_37 = 0;
          }
          float4 tmpvar_38;
          tmpvar_38.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_38.y = (in_f.xlv_TEXCOORD0.y + ((_GrabTexture_TexelSize.y * kernely_37) * _Size));
          tmpvar_38.zw = in_f.xlv_TEXCOORD0.zw;
          float4 tmpvar_39;
          tmpvar_39 = tex2D(_GrabTexture, tmpvar_38);
          tmpvar_36 = (tmpvar_39 * 0.05);
          sum_3 = (sum_3 + tmpvar_36);
          float4 tmpvar_40;
          tmpvar_40 = tex2D(_GrabTexture, in_f.xlv_TEXCOORD0);
          col5_2 = tmpvar_40;
          decayFactor_1 = 1;
          if(((in_f.xlv_TEXCOORD0.x==0) && (in_f.xlv_TEXCOORD0.y==0)))
          {
              decayFactor_1 = 0;
          }
          float4 tmpvar_41;
          tmpvar_41 = lerp(col5_2, sum_3, float4(decayFactor_1, decayFactor_1, decayFactor_1, decayFactor_1));
          sum_3 = ((tmpvar_41 * in_f.xlv_COLOR) * _Color);
          out_f.color = sum_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

﻿Shader "Custom/Shader_3D" {
	Properties {
		_MainTint ("Difusse Tint",Color) = (1,1,1,1)

		_ColorA("Terrain color A", Color) = (1,1,1,1)
		_ColorB("Terrain color B", Color) = (1,1,1,1)

		_RTexture("Red Channel Texture", 2D) = ""{}
		_GTexture("Green Channel Texture", 2D) = ""{}
		_BTexture("Blue Channel Texture", 2D) = ""{}
		_ATexture("Alpha Channel Texture", 2D) = ""{}

		_BlendTex("Blend Texture", 2D) = ""{}

	
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Lambert


		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;
		sampler2D _RTexture;
		sampler2D _GTexture;
		sampler2D _BTexture;
		sampler2D _BlendTex;
		sampler2D _ATexture;
	
		#pragma target 3.5

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;

			float2 uv_RTexture;
			float2 uv_GTexture;
			float2 uv_BTexture;
			float2 uv_ATexture;
			float2 uv_BlendTex;


		};

	
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) 
		{

			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

			float4 blendData = tex2D(_BlendTex, IN.uv_BlendTex);
	
			
			ata, blendData.b);
			finalColor = lerp(finalColor, aTexData, blendData.a); finalColor.a = 1.0;

			float4 terrainLayers = lerp(_ColorA, _ColorB, blendData.r);
			finalColor *= terrainLayers;
			finalColor = saturate(finalColor);

			o.Albedo = finalColor.rgb * _MainTint.rgb;
			o.Alpha = finalColor.a;

		}
		ENDCG
	}
	FallBack "Diffuse"
}

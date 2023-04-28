//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import device_info_plus_macos
import geolocator_apple
import location
import path_provider_macos
import pdf_render
import sqflite

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  LocationPlugin.register(with: registry.registrar(forPlugin: "LocationPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SwiftPdfRenderPlugin.register(with: registry.registrar(forPlugin: "SwiftPdfRenderPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}

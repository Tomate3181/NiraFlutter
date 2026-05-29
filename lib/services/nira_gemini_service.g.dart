// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nira_gemini_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(niraGemini)
final niraGeminiProvider = NiraGeminiProvider._();

final class NiraGeminiProvider
    extends
        $FunctionalProvider<
          NiraGeminiService,
          NiraGeminiService,
          NiraGeminiService
        >
    with $Provider<NiraGeminiService> {
  NiraGeminiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'niraGeminiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$niraGeminiHash();

  @$internal
  @override
  $ProviderElement<NiraGeminiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NiraGeminiService create(Ref ref) {
    return niraGemini(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NiraGeminiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NiraGeminiService>(value),
    );
  }
}

String _$niraGeminiHash() => r'9e82ab5014e1a146a342a7697ef3e7aacdce6b97';

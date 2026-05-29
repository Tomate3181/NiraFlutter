// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nira_supabase_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(niraSupabase)
final niraSupabaseProvider = NiraSupabaseProvider._();

final class NiraSupabaseProvider
    extends
        $FunctionalProvider<
          NiraSupabaseService,
          NiraSupabaseService,
          NiraSupabaseService
        >
    with $Provider<NiraSupabaseService> {
  NiraSupabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'niraSupabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$niraSupabaseHash();

  @$internal
  @override
  $ProviderElement<NiraSupabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NiraSupabaseService create(Ref ref) {
    return niraSupabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NiraSupabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NiraSupabaseService>(value),
    );
  }
}

String _$niraSupabaseHash() => r'290203f9a918ae4ea3a60f1fac9412338403c265';

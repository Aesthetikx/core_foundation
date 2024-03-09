# frozen_string_literal: true

module CoreFoundation
  class CFUUIDBytes < FFI::Struct
    layout :byte0, :uchar,
           :byte1, :uchar,
           :byte2, :uchar,
           :byte3, :uchar,
           :byte4, :uchar,
           :byte5, :uchar,
           :byte6, :uchar,
           :byte7, :uchar,
           :byte8, :uchar,
           :byte9, :uchar,
           :byte10, :uchar,
           :byte11, :uchar,
           :byte12, :uchar,
           :byte13, :uchar,
           :byte14, :uchar,
           :byte15, :uchar
  end

  typedef :ulong,   :cf_type_id
  typedef :pointer, :cf_allocator_ref
  typedef :pointer, :cf_string_ref

  # rubocop:disable Style/SymbolArray
  attach_function :CFUUIDGetTypeID,                [],                                        :cf_type_id
  attach_function :CFUUIDCreate,                   [:cf_allocator_ref],                       CFUUIDBytes.by_ref
  attach_function :CFUUIDCreateWithBytes,          [:cf_allocator_ref, *[:uchar] * 16],       CFUUIDBytes.by_ref
  attach_function :CFUUIDCreateFromString,         [:cf_allocator_ref, :cf_string_ref],       CFUUIDBytes.by_ref
  attach_function :CFUUIDCreateString,             [:cf_allocator_ref, CFUUIDBytes.by_ref],   :cf_string_ref
  attach_function :CFUUIDGetConstantUUIDWithBytes, [:cf_allocator_ref, *[:uchar] * 16],       CFUUIDBytes.by_ref
  attach_function :CFUUIDGetUUIDBytes,             [CFUUIDBytes.by_ref],                      CFUUIDBytes.by_value
  attach_function :CFUUIDCreateFromUUIDBytes,      [:cf_allocator_ref, CFUUIDBytes.by_value], CFUUIDBytes.by_ref
  # rubocop:enable Style/SymbolArray
end

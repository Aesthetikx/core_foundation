# frozen_string_literal: true

require "ffi"

# This module is a wrapper for a subset of the CoreFoundation framework.
module CoreFoundation
  class Error < StandardError; end

  extend FFI::Library

  ffi_lib "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation"
end

require_relative "core_foundation/version"
require_relative "core_foundation/uuid"

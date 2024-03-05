# frozen_string_literal: true

RSpec.describe CoreFoundation do
  it "has a version number" do
    expect(CoreFoundation::VERSION).not_to be_nil
  end

  describe "UUID" do
    let(:allocator) { nil }

    let(:sixteen_bytes) do
      [
        0x00, 0x11, 0x22, 0x33,
        0x44, 0x55, 0x66, 0x77,
        0x88, 0x99, 0xAA, 0xBB,
        0xCC, 0xDD, 0xEE, 0xFF
      ]
    end

    describe "::CFUUIDGetTypeID" do
      it "returns a CFUUID type ID" do
        expect(described_class.CFUUIDGetTypeID).to eq(0x22)
      end
    end

    describe "::CFUUIDCreate" do
      it "returns a CFUUIDRef" do
        uuid = described_class.CFUUIDCreate(allocator)

        expect(uuid).not_to be_null
      end
    end

    describe "::CFUUIDCreateWithBytes" do
      it "returns a CFUUIDRef" do
        uuid = described_class.CFUUIDCreateWithBytes(allocator, *sixteen_bytes)

        expect(uuid).not_to be_null
      end
    end

    describe "::CFUUIDCreateFromString" do
      it "returns a CFUUIDRef" do
        uuid = described_class.CFUUIDCreateWithBytes(allocator, *sixteen_bytes)

        string = described_class.CFUUIDCreateString(allocator, uuid)

        new_uuid_ref = described_class.CFUUIDCreateFromString(allocator, string)

        new_uuid = described_class.CFUUIDGetUUIDBytes(new_uuid_ref)

        expect(new_uuid[:byte15]).to eq(0xFF)
      end
    end

    describe "::CFUUIDCreateString" do
      it "returns a CFStringRef" do
        uuid = described_class.CFUUIDCreateWithBytes(allocator, *sixteen_bytes)

        string = described_class.CFUUIDCreateString(allocator, uuid)

        expect(string).not_to be_null
      end
    end

    describe "::CFUUIDGetConstantUUIDWithBytes" do
      it "returns a CFUUIDRef" do
        uuid = described_class.CFUUIDGetConstantUUIDWithBytes(allocator, *sixteen_bytes)

        expect(uuid).not_to be_null
      end
    end

    describe "::CFUUIDGetUUIDBytes" do
      it "returns a CFUUIDBytes" do
        uuid = described_class.CFUUIDCreateWithBytes(allocator, *sixteen_bytes)

        cfuuid_bytes = described_class.CFUUIDGetUUIDBytes(uuid)

        expect(cfuuid_bytes[:byte15]).to eq(0xFF)
      end
    end

    describe "::CFUUIDCreateFromUUIDBytes" do
      it "returns a CFUUIDRef" do
        cfuuid_bytes = CoreFoundation::CFUUIDBytes.new

        sixteen_bytes.each_with_index { |byte, i| cfuuid_bytes[:"byte#{i}"] = byte }

        uuid = described_class.CFUUIDCreateFromUUIDBytes(allocator, cfuuid_bytes)

        expect(uuid).not_to be_null
      end
    end
  end
end

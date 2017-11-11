local pmbus = require 'pmbus'
local bit = require 'bit'
local bin = require 'struct'
local ffi = require "ffi"

ffi.cdef "unsigned int sleep(unsigned int seconds);"

local rshift, bor, band = bit.rshift, bit.bor, bit.band
local stpack, stunpack = bin.pack, bin.unpack

local function sleep(n)
    ffi.C.sleep(n)
end

local i, b
local banks = {}
for i=9,15 do
    b = pmbus:new(i, 0x10)
    table.insert(banks, b)
end

for k=0,5 do
    for i, b in ipairs(banks) do
        print('BANK ', i)
        b:read_attributes()
    end
    print('Waiting...')
    sleep(3)
end

--local data, err = bank0:read_cmd(pmbus.PMBUS_MFR_SERIAL, 16)
--print(stunpack('Bc0', data))

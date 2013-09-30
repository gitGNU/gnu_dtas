# Copyright (C) 2013, Eric Wong <normalperson@yhbt.net> and all contributors
# License: GPLv3 or later (https://www.gnu.org/licenses/gpl-3.0.txt)
require_relative '../dtas'
class DTAS::CueIndex
  attr_reader :offset
  attr_reader :index

  def initialize(index, offset)
    @index = index.to_i

    # must be compatible with the sox "trim" effect
    @offset = offset # "#{INTEGER}s" (samples) or HH:MM:SS:FRAC
  end

  def to_hash
    { "index" => @index, "offset" => @offset }
  end

  def offset_samples(format)
    case @offset
    when /\A(\d+)s\z/
      $1.to_i
    else
      format.hhmmss_to_samples(@offset)
    end
  end

  def pregap?
    @index == 0
  end

  def track?
    @index == 1
  end

  def subindex?
    @index > 1
  end
end
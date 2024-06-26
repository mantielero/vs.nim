

#[
==================================
NUT Open Container Format 20131223
==================================



Intro:
======

NUT is a free multimedia container format for storage of audio, video,
subtitles and related user defined streams, it provides exact timestamps for
synchronization and seeking, is simple, has low overhead and can recover
in case of errors in the stream.

Other common multimedia container formats are AVI, Ogg, Matroska, MP4, MOV
ASF, MPEG-PS, MPEG-TS.


Features / goals:
    (supported by the format, not necessarily by a specific implementation)

Simplicity
    Use the same encoding for nearly all fields.
    Simple decoding, so slow CPUs (and embedded systems) can handle it.

Extensibility
    No limit for the possible values of all fields (using universal vlc).
    Allow adding of new headers in the future.
    Allow adding more fields at the end of headers.

Compactness
    ~0.2% overhead for normal bitrates.
    The index is <100kb per hour.
    A typical file header is about 100 bytes (audio + video headers together).
    A packet header is about ~1-5 bytes.

Error resistance
    Seeking / playback is possible without an index.
    Headers & index can be repeated.
    Damaged files can be played back with minimal data loss and fast
    resynchronization times.

The specification is frozen. All files following the specification will be
compatible unless the specification is unfrozen.


Definitions:
============

MUST    The specific part must be done to conform to this standard.
SHOULD  It is recommended to be done that way, but not strictly required.

keyframe
    A keyframe is a frame from which you can start decoding, a more
    exact definition is below

    A frame in a stream is a keyframe if and only if all of the following
    are true:
    * Decoding can successfully begin using any standard-compliant decoder
      without requiring access to prior frames.
    * Starting decoding at a subsequent frame would cause fewer frames
      to be decoded successfully.

    Successful decoding here means that a specific decoded frame is
    virtually identical to what one would get, had decoding begun from
    the very first frame.
    Note, "virtually identical" is used here instead of "identical" to allow
    codecs which converge toward the same output when started from different
    points but do not necessarily ever reach exactly identical output.

    Every frame which is marked as a keyframe MUST be a keyframe according to
    the definition above, a muxer MUST mark every frame it knows is a keyframe
    as such, a muxer SHOULD NOT analyze future frames to determine the
    keyframe status of the current frame but instead just set the frame as
    non-keyframe.
    (FIXME maybe move somewhere else?)
pts
    Presentation time of the first frame/sample that is completed by decoding
    the coded frame.
dts
    The time when a frame is input into a synchronous 1-in-1-out decoder.

EOR frames
    End of relevance frames indicate that a given stream is not relevant
    for presentation beginning with the EOR frame and until the following
    keyframe. This is primarily intended for periods where subtitles are
    not displayed. But it is not limited to subtitles.


Syntax:
=======

Since NUT heavily uses variable length fields, the simplest way to describe it
is using a pseudocode approach.



Conventions:
============

The data types have a name, used in the bitstream syntax description, a short
text description and a pseudocode (functional) definition, optional notes may
follow:

name    (text description)
    functional definition
    [Optional notes]

The bitstream syntax elements have a tagname and a functional definition, they
are presented in a bottom-up approach, again optional notes may follow and
are reproduced in the tag description:

name:    (optional note)
    functional definition
    [Optional notes]

The in-depth tag description follows the bitstream syntax.
The functional definition has a C-like syntax.



Type definitions:
=================

f(n)    (n fixed bits in big-endian order)
u(n)    (unsigned number encoded in n bits in MSB-first order)

v   (variable length value, unsigned)
    value=0
    do{
        more_data                       u(1)
        data                            u(7)
        value= 128*value + data
    }while(more_data)

s   (variable length value, signed)
    temp                                v
    temp++
    if(temp&1) value= -(temp>>1)
    else       value=  (temp>>1)

b   (binary data or string, to be use in vb, see below)
    for(i=0; i<length; i++){
        data[i]                         u(8)
    }
    [Note: strings MUST be encoded in UTF-8]
    [Note: the character NUL (U+0000) is not legal within
    or at the end of a string.]

vb  (variable length binary data or string)
    length                              v
    value                               b

t (v coded universal timestamp)
    tmp                                 v
    id= tmp % time_base_count
    value= (tmp / time_base_count) * time_base[id]


Bitstream syntax:
=================

file:
    file_id_string
    while(!eof){
        if(next_byte == 'N'){
            packet_header
            switch(startcode){
                case      main_startcode:  main_header; break;
                case    stream_startcode:stream_header; break;
                case      info_startcode:  info_packet; break;
                case     index_startcode:        index; break;
                case syncpoint_startcode:    syncpoint; break;
            }
            packet_footer
        }else
            frame
    }

The structure of an undamaged file should look like the following, but
demuxers should be flexible and be able to deal with damaged headers so the
above is a better loop in practice (not to mention it is simpler).
Note: Demuxers MUST ignore new and unknown headers.

file:
    file_id_string
    while(!eof){
        packet_header, main_header, packet_footer
        reserved_headers
        for(i=0; i<stream_count; i++){
            packet_header, stream_header, packet_footer
            reserved_headers
        }
        while(next_code == info_startcode){
            packet_header, info_packet, packet_footer
            reserved_headers
        }
        if(next_code == index_startcode){
            packet_header, index_packet, packet_footer
        }
        if (!eof) while(next_code != main_startcode){
            if(next_code == syncpoint_startcode){
                packet_header, syncpoint, packet_footer
            }
            frame
            reserved_headers
        }
    }


Common elements:
----------------

reserved_bytes:
    for(i=0; i<forward_ptr - length_of_non_reserved; i++)
        reserved                        u(8)
    [A demuxer MUST ignore any reserved bytes.
    A muxer MUST NOT write any reserved bytes, as this would make it
    impossible to add new fields at the end of packets in the future
    in a compatible way.]

packet_header
    startcode                           f(64)
    forward_ptr                         v
    if(forward_ptr > 4096)
        header_checksum                 u(32)

packet_footer
    checksum                            u(32)

reserved_headers
    while(next_byte == 'N' && next_code !=      main_startcode
                           && next_code !=    stream_startcode
                           && next_code !=      info_startcode
                           && next_code !=     index_startcode
                           && next_code != syncpoint_startcode){
        packet_header
        reserved_bytes
        packet_footer
    }

        Headers:

main_header:
    version                             v
    if (version > 3)
        minor_version                   v
    stream_count                        v
    max_distance                        v
    time_base_count                     v
    for(i=0; i<time_base_count; i++)
        time_base_num                   v
        time_base_denom                 v
        time_base[i]= time_base_num/time_base_denom
    tmp_pts=0
    tmp_mul=1
    tmp_stream=0
    tmp_match=1-(1<<62)
    tmp_head_idx= 0;
    for(i=0; i<256; ){
        tmp_flag                        v
        tmp_fields                      v
        if(tmp_fields>0) tmp_pts        s
        if(tmp_fields>1) tmp_mul        v
        if(tmp_fields>2) tmp_stream     v
        if(tmp_fields>3) tmp_size       v
        else tmp_size=0
        if(tmp_fields>4) tmp_res        v
        else tmp_res=0
        if(tmp_fields>5) count          v
        else count= tmp_mul - tmp_size
        if(tmp_fields>6) tmp_match      s
        if(tmp_fields>7) tmp_head_idx   v
        for(j=8; j<tmp_fields; j++){
            tmp_reserved[i]             v
        }
        for(j=0; j<count && i<256; j++, i++){
            if (i == 'N') {
                flags[i]= FLAG_INVALID;
                j--;
                continue;
            }
            flags[i]= tmp_flag;
            stream_id[i]= tmp_stream;
            data_size_mul[i]= tmp_mul;
            data_size_lsb[i]= tmp_size + j;
            pts_delta[i]= tmp_pts;
            reserved_count[i]= tmp_res;
            match_time_delta[i]= tmp_match;
            header_idx[i]= tmp_head_idx;
        }
    }
    header_count_minus1                  v
    for(i=0; i<header_count_minus1; i++)
        elision_header[i+1]             vb
    main_flags                          v
    reserved_bytes

stream_header:
    stream_id                           v
    stream_class                        v
    fourcc                              vb
    time_base_id                        v
    msb_pts_shift                       v
    max_pts_distance                    v
    decode_delay                        v
    stream_flags                        v
    codec_specific_data                 vb
    if(stream_class == video){
        width                           v
        height                          v
        sample_width                    v
        sample_height                   v
        colorspace_type                 v
    }else if(stream_class == audio){
        samplerate_num                  v
        samplerate_denom                v
        channel_count                   v
    }
    reserved_bytes

        Basic Packets:

frame:
    frame_code                          f(8)
    frame_flags= flags[frame_code]
    frame_res= reserved_count[frame_code]
    if(frame_flags&FLAG_CODED){
        coded_flags                     v
        frame_flags ^= coded_flags
    }
    if(frame_flags&FLAG_STREAM_ID){
        stream_id                       v
    }
    if(frame_flags&FLAG_CODED_PTS){
        coded_pts                       v
    }
    if(frame_flags&FLAG_SIZE_MSB){
        data_size_msb                   v
    }
    if(frame_flags&FLAG_MATCH_TIME){
        match_time_delta                s
    }
    if(frame_flags&FLAG_HEADER_IDX){
        header_idx                      v
    }
    if(frame_flags&FLAG_RESERVED)
        frame_res                       v
    for(i=0; i<frame_res; i++)
        reserved                        v
    if(frame_flags&FLAG_CHECKSUM){
        checksum                        u(32)
    }
    data

data:
    if (frame_flags&FLAG_SM_DATA) {
        side_data
        meta_data
    }
    frame_data

sm_data:
    count                               v
    for(i=0; i<count; i++){
        name                            vb
        value                           s
        if (value==-1){
            type= "UTF-8"
            value                       vb
        }else if (value==-2){
            type                        vb
            value                       vb
        }else if (value==-3){
            type= "s"
            value                       s
        }else if (value==-4){
            type= "t"
            value                       t
        }else if (value<-4){
            type= "r"
            value.den= -value-4
            value.num                   s
        }else{
            type= "v"
        }
    }

side_data
    sm_data

meta_data
    sm_data


index:
    max_pts                             t
    syncpoints                          v
    for(i=0; i<syncpoints; i++){
        syncpoint_pos_div16             v
    }
    for(i=0; i<stream_count; i++){
        last_pts= -1
        for(j=0; j<syncpoints; ){
            x                           v
            type= x & 1
            x>>=1
            n=j
            if(type){
                flag= x & 1
                x>>=1
                while(x--)
                    has_keyframe[n++][i]=flag
                has_keyframe[n++][i]=!flag;
            }else{
                while(x != 1){
                    has_keyframe[n++][i]=x&1;
                    x>>=1;
                }
            }
            for(; j<n && j<syncpoints; j++){
                if (!has_keyframe[j][i]) continue
                A                           v
                if(!A){
                    A                       v
                    B                       v
                    eor_pts[j][i] = last_pts + A + B
                }else
                    B=0
                keyframe_pts[j][i] = last_pts + A
                last_pts += A + B
            }
        }
    }
    reserved_bytes
    index_ptr                           u(64)

info_packet:
    stream_id_plus1                     v
    chapter_id                          s (Note: Due to a typo this was v
                                           until 2006-11-04.)
    chapter_start                       t
    chapter_len                         v
    meta_data
    reserved_bytes

syncpoint:
    global_key_pts                      t
    back_ptr_div16                      v
    if(main_flags & BROADCAST_MODE)
        transmit_ts                     t
    reserved_bytes

            Complete definition:


Tag description:
----------------

file_id_string
    "nut/multimedia container\0"
    The very first thing in every NUT file, useful for identifying NUT files.

*_startcode (f(64))
    all startcodes start with 'N'

main_startcode (f(64))
    0x7A561F5F04ADULL + (((uint64_t)('N'<<8) + 'M')<<48)

stream_startcode (f(64))
    0x11405BF2F9DBULL + (((uint64_t)('N'<<8) + 'S')<<48)

syncpoint_startcode (f(64))
    0xE4ADEECA4569ULL + (((uint64_t)('N'<<8) + 'K')<<48)

index_startcode (f(64))
    0xDD672F23E64EULL + (((uint64_t)('N'<<8) + 'X')<<48)

info_startcode (f(64))
    0xAB68B596BA78ULL + (((uint64_t)('N'<<8) + 'I')<<48)

version (v)
    NUT version. The current value is 3. All lower values are pre-freeze.

minor_version (v)
    NUT minor_version. This represents minor changes in the specification
    which do not affect compatibility. Demuxers MUST NOT reject files
    based on this value.
    The current value is 0

stream_count (v)
    number of streams in this file

time_base_count (v)
    number of different time bases in this file
    This MUST NOT be 0.

forward_ptr (v)
    Size of the packet data (exactly the distance from the first byte
    after the packet_header to the first byte of the next packet).
    Every NUT packet contains a forward_ptr immediately after its startcode
    with the exception of frame_code-based packets. The forward pointer
    can be used to skip over the packet without decoding its contents.

max_distance (v)
    maximum distance between startcodes. If p1 and p2 are the byte
    positions of the first byte of two consecutive startcodes, then
    p2-p1 MUST be less than or equal to max_distance unless the entire
    span from p1 to p2 comprises a single packet or a syncpoint
    followed by a single frame. This imposition places efficient upper
    bounds on seek operations and allows for the detection of damaged
    frame headers, should a chain of frame headers pass max_distance
    without encountering any startcode.

    Syncpoints SHOULD be placed immediately before a keyframe if the
    previous frame of the same stream was a non-keyframe, unless such
    non-keyframe - keyframe transitions are very frequent.

    SHOULD be set to <=32768.
    If the stored value is >65536 then max_distance MUST be set to 65536.

    This is also half the maximum frame size without a checksum after the
    frame header.

main_flags (v)
    Bit Name            Description
    0   BROADCAST_MODE  Set if broadcast mode is in use.


max_pts_distance (v)
    Maximum absolute difference of the pts of the new frame from last_pts in
    the timebase of the stream, without a checksum after the frame header.
    A frame header MUST include a checksum if abs(pts-last_pts) is
    strictly greater than max_pts_distance.
    Note that last_pts is not necessarily the pts of the last frame
    on the same stream, as it is altered by syncpoint timestamps.
    SHOULD NOT be higher than 1/timebase.

stream_id (v)
    Stream identifier
    stream_id MUST be < stream_count

stream_class (v)
    0    video
    1    audio
    2    subtitles
    3    user data
    Note: The remaining values are reserved and MUST NOT be used.
          A demuxer MUST ignore streams with reserved classes.

fourcc (vb)
    identification for the codec
    example: "H264"
    MUST contain 2 or 4 bytes, note, this might be increased in the future
    if needed.
    The ID values used are the same as in AVI, so if a codec uses a specific
    FourCC in AVI then the same FourCC MUST be used here.
    For raw video and audio, the used sample format (signed/unsigned,
    8/16/32bit, big/little endian, rgb/yuv) is indicated by the fourcc.

time_base_num (v) / time_base_denom (v) = time_base
    the length of a timer tick in seconds, this MUST be equal to the 1/fps
    if FLAG_FIXED_FPS is set
    time_base_num and time_base_denom MUST NOT be 0
    time_base_num and time_base_denom MUST be relatively prime
    time_base_num MUST be < 2^31
    time_base_denom MUST be < 2^31
    examples:
        fps       time_base_num    time_base_denom
        30        1                30
        29.97     1001             30000
        23.976    1001             24000
    There MUST NOT be 2 identical timebases in a file.
    There SHOULD NOT be more timebases than streams.

time_base_id (v)
    index into the time_base table
    MUST be < time_base_count.

convert_ts
    To switch from 2 different timebases, the following calculation is
    defined:

    ln        = from_time_base_num*from_timestamp
    sn        = to_time_base_denom
    d1        = from_time_base_denom
    d2        = to_time_base_num
    timestamp = (ln/d1*sn + ln%d1*sn/d1)/d2
    Note: This calculation MUST be done with unsigned 64 bit integers, and
    is equivalent to (ln*sn)/(d1*d2) but this would require a 96 bit integer.

compare_ts
    Compares timestamps from 2 different timebases,
    if a is before b then compare_ts(a, b) = -1
    if a is after  b then compare_ts(a, b) =  1
    else                  compare_ts(a, b) =  0

    Care must be taken that this is done exactly with no rounding errors,
    simply casting to float or double and doing the obvious
    a*timebase > b*timebase is not compliant or correct, neither is the
    same with integers, and
    a*a_timebase.num*b_timebase.den > b*b_timebase.num*a_timebase.den
    will overflow. One possible implementation which shouldn't overflow
    within the range of legal timestamps and timebases is:

    if (convert_ts(a, a_timebase, b_timebase) < b) return -1;
    if (convert_ts(b, b_timebase, a_timebase) < a) return  1;
    return 0;

msb_pts_shift (v)
    amount of bits in lsb_pts
    MUST be <16.

decode_delay (v)
    Size of the reordering buffer used to convert pts to dts.
    Codecs which do not support B-frames normally use 0.
    MPEG-1/MPEG-2-style codecs with B-frames use 1.
    H.264-style B-pyramid uses 2.
    H.264 and future codecs might need values >2.
    Audio codecs generally use 0. (We are not aware of any, but it
    is theoretically possible that a codec might need a value >0.)
    decode_delay MUST NOT be set higher than necessary for a codec.

stream_flags (v)
     Bit  Name            Description
       1  FLAG_FIXED_FPS  indicates that the fps is fixed

codec_specific_data (vb)
    Private global data for a codec (could be Huffman tables or ...).
    If a codec has a global header it SHOULD be placed in here instead of
    at the start of every keyframe.
    The exact format is specified in the codec specification.
    For H.264 the NAL units MUST be formatted as in a bytestream
    (with 00 00 01 prefixes).
    codec_specific_data SHOULD contain exactly the essential global packets
    needed to decode a stream, more specifically it SHOULD NOT contain packets
    which contain only non essential metadata like author, title, ...
    It also MUST NOT contain normal packets which cause the reference decoder
    to generate any specific decoded samples.
    The encoder name and version shall be considered essential as it is very
    useful to work around possible encoder bugs.
    The global headers MUST consist of the normal
    sequence of header packets required for codec initialization, in the
    order defined in the codec spec. An implementation MAY strip metadata and
    other redundant information not necessary for correct playback from the
    global headers as long as no incorrect values are stored and as long as
    the stripped result is not less valid per codec spec as before stripping.

frame_code (f(8))
    frame_code is an 8 bit field which exists before every frame. It can
    store part of the size of the frame, the stream number, the timestamp
    and some flags amongst other things. What is not directly stored
    in it but is needed is stored in various fields immediately after it.
    The values stored in it can be found in the main header.
    The value 78 ('N') is forbidden to ensure that the byte is always
    different from the first byte of any startcode.
    A muxer SHOULD mark 0x00 and 0xFF as invalid to improve error
    detection.

flags[frame_code], frame_flags (v)
     Bit  Name             Description
       0  FLAG_KEY         If set, the frame is a keyframe.
       1  FLAG_EOR         If set, the stream has no relevance on
                           presentation. (EOR)
       3  FLAG_CODED_PTS   If set, coded_pts is in the frame header.
       4  FLAG_STREAM_ID   If set, stream_id is coded in the frame header.
       5  FLAG_SIZE_MSB    If set, data_size_msb is coded in the frame header,
                           otherwise data_size_msb is 0.
       6  FLAG_CHECKSUM    If set, the frame header contains a checksum.
       7  FLAG_RESERVED    If set, reserved_count is coded in the frame header.
       8  FLAG_SM_DATA     If set, side/meta data is stored with the frame data.
                           This flag MUST NOT be set in version < 4
      10  FLAG_HEADER_IDX  If set, header_idx is coded in the frame header.
      11  FLAG_MATCH_TIME  If set, match_time_delta is coded in the frame
                           header
      12  FLAG_CODED       If set, coded_flags are stored in the frame header.
      13  FLAG_INVALID     If set, frame_code is invalid.

    EOR frames MUST be zero-length and must be set keyframe.
    All streams SHOULD end with EOR, where the pts of the EOR indicates the
    end presentation time of the final frame.
    An EOR set stream is unset by the first content frame.
    EOR can only be unset in streams with zero decode_delay .
    FLAG_CHECKSUM MUST be set if the frame's data_size is strictly greater than
    2*max_distance or the difference abs(pts-last_pts) is strictly greater than
    max_pts_distance (where pts represents this frame's pts and last_pts is
    defined as below).

last_pts
    The timestamp of the last frame with the same stream_id as the current.
    If there is no such frame between the last syncpoint and the current
    frame then the syncpoint timestamp is used, see global_key_pts.

stream_id[frame_code] (v)
    If FLAG_STREAM_ID is not set then this is the stream number for the
    frame following this frame_code.
    If FLAG_STREAM_ID is set then this value has no meaning.
    MUST be <250.

data_size_mul[frame_code] (v)
    If FLAG_SIZE_MSB is set then data_size_msb which is stored after the
    frame code is multiplied with it and forms the more significant part
    of the size of the following frame.
    If FLAG_SIZE_MSB is not set then this field has no meaning.
    MUST be <16384.

data_size_lsb[frame_code] (v)
    The less significant part of the size of the following frame.
    This added together with data_size_mul*data_size_msb is the size of
    the following frame.
    MUST be <16384.

pts_delta[frame_code] (s)
    If FLAG_CODED_PTS is set in the flags of the current frame then this
    value MUST be ignored, if FLAG_CODED_PTS is not set then pts_delta is the
    difference between the current pts and last_pts.
    MUST be <16384 and >-16384.

reserved_count[frame_code] (v)
    MUST be <256.

sm_data / side_data / meta_data
    This data structure is used both in frames for per frame side and metadata
    as well as info tags for metadata covering the whole file, a stream
    chapter or other.
    Metadata is data that is about the actual data and generally not essential
    for correct presentation
    Sidedata is semantically part of the data and essential for its correct
    presentation. The same syntax is used by both for simplicity.
    Types of per frame side data:
    "Channels", "ChannelLayout", "SampleRate", "Width", "Height"
        This frame changes the number of channels, the channel layout, ... to
        the given value (ChannelLayout vb, else v)
        If used in any frame of a stream then every keyframe of the stream
        SHOULD carry such sidedata to allow seeking.
    "Extradata", "Palette"
        This frame changes the codec_specific_data or palette to the given
        value (vb)
        If used in any frame of a stream then every keyframe of the stream
        SHOULD carry such sidedata to allow seeking.
    "CodecSpecificSide<num>"
        Codec specific side data, equivalent to matroskas BlockAdditional (vb)
        the "<num>" should be replaced by a number identifying the type of
        side data, it is equivalent/equal to BlockAddId in matroska.
    "SkipStart", "SkipEnd"
        The decoder should skip/drop the specified number of samples at the
        start/end of this frame (v)
    "UserData<identifer here>"
        User specific side data, the "<identifer here>" should be replaced
        by a globally unique identifer of the project that
        uses/creates/understands the side data. For example "UserDataFFmpeg"

data_size
    data_size = data_size_lsb + data_size_msb * data_size_mul ;
    The size of the following frame, including a possible elision header.
    If data_size is 500 bytes, and it has an elision header of 10 bytes,
    then the stored frame data following the frame header is 490 bytes.

coded_pts (v)
    If coded_pts < ( 1 << msb_pts_shift ) then it is an lsb
    pts, otherwise it is a full pts + ( 1 << msb_pts_shift ).
    lsb pts is converted to a full pts by:
    mask  = ( 1 << msb_pts_shift ) - 1;
    delta = last_pts - mask / 2
    pts   = ( (pts_lsb - delta) & mask ) + delta

match_time_delta (s)
    This is the time difference in stream timebase units from the pts at which
    the output from the decoder has converged independent from the availability
    of previous frames (that is the frames are virtually identical no matter
    if decoding started from the very first frame or from this keyframe).
    If its value is 1-(1<<62) then match_time_delta is unspecified, that is
    the muxer lacked sufficient information to set it.
    A muxer MUST only set it to 1-(1<<62) if it does not know the correct
    value. That is, it is not allowed to randomly discard known values.

match_time_delta[frame_code] (s)
    If FLAG_MATCH_TIME is not set then this value shall be used for
    match_time_delta, otherwise this value is ignored.
    MUST be <32768 and >-32768 or =1-(1<<62).

header_idx[frame_code] (v)
    The index into the elision_header table.
    MUST be <128.

header_count_minus1 (v)
    The number of distinct non empty elision headers.
    MUST be <128.

elision_header[header_idx] (vb)
    For frames with a final size <= 4096 this header is prepended to the
    frame data. That is if the stored frame is 4000 bytes and the
    elision_header is 96 bytes then it is prepended, if it is 97 byte then it
    is not.
    elision_header[0] is fixed to a length 0 header.
    The length of each elision_header except header 0 MUST be < 256 and >0.
    The sum of the lengthes of all elision_headers MUST be <=1024.

lsb_pts
    Least significant bits of the pts in time_base precision.
        Example: IBBP display order
        keyframe pts=0                       -> pts=0
        frame                    lsb_pts=3   -> pts=3
        frame                    lsb_pts=1   -> pts=1
        frame                    lsb_pts=2   -> pts=2
        ...
        keyframe msb_pts=257                 -> pts=257
        frame                    lsb_pts=255 -> pts=255
        frame                    lsb_pts=0   -> pts=256
        frame                    lsb_pts=4   -> pts=260
        frame                    lsb_pts=2   -> pts=258
        frame                    lsb_pts=3   -> pts=259
    All pts values of keyframes of a single stream MUST be monotone.

dts
    decoding timestamp
    The dts of a frame is the timestamp of the first sample which is
    output by a decoder when it is fed with the frame. Note that the
    data output is not necessarily what is coded in the frame, but may
    be data from previous frames.
    dts is calculated by using a decode_delay + 1 sized buffer for each
    stream, into which the current pts is inserted and the element with
    the smallest value is removed. This is then the current dts.
    This buffer is initialized with decode_delay - 1 elements.

    pts of all frames in all streams MUST be bigger or equal to dts of all
    previous frames in all streams, compared in common timebase. (EOR
    frames are NOT exempt from this rule.)
    dts of all frames MUST be bigger or equal to dts of all previous frames
    in the same stream.

    If a codec spec defines dts in a way incompatible to this then the decoder
    dts shall be considered to be entirely outside the nut spec. In this case
    a decoder compatible with a nut demuxer will output/display decoded frames
    purely based on the pts values stored in a nut file.
    Such nut files MUST NOT contain non standard fields conveying these codec
    dts as this would break remuxing, spliting, merging and time scaling by
    (de)muxers unaware of these non standard fields.

width (v) / height (v)
    Width and height of the video in pixels.
    MUST be set to the coded width/height, MUST NOT be 0.

sample_width (v) /sample_height (v) (aspect ratio)
    sample_width is the horizontal distance between samples.
    sample_width and sample_height MUST be relatively prime if not zero.
    Both MUST be 0 if unknown otherwise both MUST be nonzero.

colorspace_type (v)
     0    unknown
     1    ITU Rec 624 / ITU Rec 601 Y range: 16..235 Cb/Cr range: 16..240
     2    ITU Rec 709               Y range: 16..235 Cb/Cr range: 16..240
    17    ITU Rec 624 / ITU Rec 601 Y range:  0..255 Cb/Cr range:  0..255
    18    ITU Rec 709               Y range:  0..255 Cb/Cr range:  0..255

samplerate_num (v) / samplerate_denom (v) = samplerate
    The number of samples per second, MUST NOT be 0.

crc32 checksum
    Generator polynomial is 0x104C11DB7. Starting value is zero.

checksum (u(32))
    crc32 checksum
    The checksum is calculated for the area pointed to by forward_ptr
    not including the checksum itself (from first byte after the
    packet_header until last byte before the checksum).
    For frame headers the checksum contains the framecode byte and all
    following bytes up to the checksum itself.

header_checksum (u(32))
    Checksum over the startcode and forward pointer.

Syncpoint tags:
---------------

back_ptr_div16 (v)
    back_ptr = back_ptr_div16 * 16 + 15
    back_ptr must point to a position up to 15 bytes before a syncpoint
    startcode, relative to position of current syncpoint. The syncpoint
    pointed to MUST be the closest syncpoint such that at least one keyframe
    with a pts+match_time_delta lower or equal to the current syncpoint's
    global_key_pts for
    all streams lies between it and the current syncpoint.

    A stream where EOR is set is to be ignored for back_ptr.

global_key_pts (t)
    After a syncpoint, last_pts of each stream is to be set to:
    last_pts[i] = convert_ts(global_key_pts, time_base[id], time_base[i])

    global_key_pts MUST be bigger or equal to dts of all past frames across
    all streams, and smaller or equal to pts of all future frames.

transmit_ts (t)
    The value of the reference clock at the moment when the first bit of
    transmit_ts is transmitted/received.
    The reference clock MUST always be less than or equal to the DTS of
    every not yet completely received frame.

Index tags:
-----------

max_pts (t)
    the highest pts in the entire file

syncpoints (v)
    number of indexed syncpoints

syncpoint_pos_div16 (v)
    The offset from the beginning of the file to up to 15 bytes before the
    syncpoint referred to in this index entry. Relative to position of last
    syncpoint.

has_keyframe
    Indicates whether this stream has a keyframe between this syncpoint and
    the last syncpoint.

keyframe_pts
    The pts+match_time_delta of the first keyframe for this stream in the
    region between the
    2 syncpoints, in the stream's timebase. (EOR frames are also keyframes.)

eor_pts
    Coded only if EOR is set at the position of the syncpoint. The pts of
    that EOR. EOR is unset by the first keyframe after it.

index_ptr (u(64))
    Length in bytes of the entire index, from the first byte of the
    startcode until the last byte of the checksum.
    Note: A demuxer can use this to find the index when it is written at
    EOF, as index_ptr will always be 12 bytes before the end of file if
    there is an index at all.


Info tags:
----------

stream_id_plus1 (v)
    Stream this info packet applies to. If zero, packet applies to all
    streams.

chapter_id (s)
    The ID of the chapter this packet applies to. If zero, the packet applies
    to the whole file. Positive chapter_id values represent real chapters and
    MUST NOT overlap.
    A negative chapter_id indicates a region of the file and not a real
    chapter. chapter_id MUST be unique to the region it represents.
    chapter_id n MUST NOT be used unless there are at least n chapters in the
    file.

chapter_start (t)
    timestamp of start of chapter
    2 info packets which apply to the same subset of streams SHOULD use the
    same timebase.

chapter_len (v)
    Length of chapter in the same timebase as chapter_start.

count (v)
    number of name/value pairs in this info packet

type
    for example: "UTF8" -> string or "JPEG" -> JPEG image
    "v" -> unsigned integer
    "s" -> signed integer
    "r" -> rational
    Note: Nonstandard fields should be prefixed by "X-".
    Note: MUST be less than 6 byte long (might be increased to 64 later).

info packet types
    The name of the info entry. Valid names are
    "Author"
    "Description"
    "Copyright"
    "Encoder"
        The name & version of the software used for encoding.
    "Title"
    "Cover" (allowed types are "PNG" and "JPEG")
        image of the (CD, DVD, VHS, ..) cover (preferably PNG or JPEG)
    "Source"
        "DVD", "VCD", "CD", "MD", "FM radio", "VHS", "TV", "LD"
        Optional: Appended PAL, NTSC, SECAM, ... in parentheses.
    "SourceContainer"
        "nut", "mkv", "mov", "avi", "ogg", "rm", "mpeg-ps", "mpeg-ts", "raw"
    "SourceCodecTag"
        The source codec ID like a FourCC which was used to store a specific
        stream in its SourceContainer.
    "SourceFilename"
        The filename of the source.
    "CaptureDevice"
        "BT878", "BT848", "webcam", ... (or more precise names)
    "CreationTime"
        "2003-01-20 20:13:15Z", ...
        (ISO 8601 format, see http://www.cl.cam.ac.uk/~mgk25/iso-time.html)
        Note: Do not forget the timezone.
    "Keywords"
    "Language"
        An ISO 639-2/B (three-letter) language code, optionally followed by an
        ISO 3166-1 country code that is separated from the language
        code by a hyphen.  All codes defined in ISO 639-2/B are allowed,
        including "und" (Undetermined), "mul" (Multiple languages).
        See http://www.loc.gov/standards/iso639-2/
        and http://www.din.de/gremien/nas/nabd/iso3166ma/codlstp1/en_listp1.html
        A demuxer MUST ignore unknown language and country codes instead of
        treating them as an error.
    "Disposition"
        "original", "dub" (translated), "comment", "lyrics", "karaoke",
        "default"
            Streams which the creator of the file intended to be played by
            default. A player can follow this suggestion or ignore it.
        Note: If someone needs some others, please tell us about them, so we
              can add them to the official standard (if they are sane).
        Note: Nonstandard fields should be prefixed by "X-".
        Note: Names of fields SHOULD be in English if a word with the same
              meaning exists in English.
        Note: MUST be less than 64 bytes long.
    "TargetAudience"
        "default", "visually impaired", "hearing impaired"
    "Replaces"
        v (stream id)
        This stream is a superior alternative (higher resolution or otherwise)
        of the given stream. It should be preferred if the decoder is capable
        of decoding it.
    "Depends"
        v (stream id)
        This stream depends on the specified stream. That is if the specified
        stream is unavailable then this stream cannot be decoded. This is used
        to store dependencies for scalability for example.
    "Uses"
        v (stream id)
        This stream can use the specified stream. But the existence of the
        specified stream is not mandatory for decoding this stream, although
        quality might suffer if it is unavailable. Examples: font attachments
        or higher quality samples from musical instruments
    "UsesFont"
        "Times New Roman", "Arial", ... FIXME should we use the filename
        instead? is there some other unique way to identify fonts?
        This stream uses the specified font, if it is unavailable presentation
        might be less pretty.
    Note: Nonstandard fields should be prefixed by "X-".

value
    value of this name/type pair

stuffing
    0x80 can be placed in front of any type v entry for stuffing purposes.
    Exceptions are the forward_ptr and all fields in the frame header where
    a maximum of 8 stuffing bytes per field are allowed.


Structure:
----------

The headers MUST be in exactly the following order (to simplify demuxer design).

main header
stream_header (id=0)
stream_header (id=1)
...
stream_header (id=n)

Headers may be repeated, but if they are, then all mandatory headers MUST be
repeated and repeated headers MUST be identical.

Each set of repeated headers not at the beginning or end of the file SHOULD
be stored at the earliest possible position after 2^x where x is an integer.
So the headers may be repeated at 4102 if that is the closest position after
2^12=4096 at which the headers can be placed.

Note: This allows an implementation reading the file to locate backup
headers in O(log filesize) time as opposed to O(filesize).

All headers MUST be placed at least at the start of the file.
Mandatory headers MUST additionally be placed immediately before
the index or at the end of the file if there is no index.
Mandatory headers MUST be repeated at least twice (so they exist three times
in a file).

There MUST be a syncpoint immediately before the first frame after any headers.

The main header is mandatory, so are all stream headers except those for
redundant and enhancement streams. So for example if the file contains 2
independent video streams encoding the same content at 2 different bitrates.
Then only one is mandatory, which that is, is at the discretion of the muxer.
Enhancement streams like font attachments are also non-mandatory.
The muxer SHOULD repeat non-mandatory headers like mandatory ones if
the overhead is not excessive.


Random Access (seeking) considerations:
---------------------------------------
Decoding can only start at a keyframe. Thus if efficient seeking with at
least a granularity of N seconds is wanted, then it is neccessary to have
at least 1 keyframe every N seconds in every stream.

Furthermore, to start correct "presentation" (after seeking) it is necessary
to have a decoded frame from every stream at approximately the same time.
Thus it is important to have closely placed keyframes in all streams at least
once every N seconds. This is equivalent to having frequent, short back
pointers.
Good example:
Video:           .....K...........................................K...........
Audio:           KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
Subtitle:        ..K............................................K.....K.......
shortest back ptrs:<--o
                      <-----------------------------------------o
                                                                <-o
                                                                  <---o
Bad example:
Video:           .....K...........................................K...........
Audio:           KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
Subtitle:        ..........................K..................................
shortest back ptrs:   <--------------------o
                                           <----------------------o

In the bad example a player would have to demux and decode half of the video
between the 2 keyframes to start correct playback if it favors the shortest
back pointer. A player could of course also choose to ignore subtitles and
thus not display them between the video keyframe and subtitle frame. This
would avoid the decoding but not necessarily demuxing and of course would
lead to incorrect display (no subtitles). An encoding application SHOULD thus
try to reasonably align keyframes in time. This could be achieved by repeating
subtitle packets at video keyframes (with appropriately adjusted start/end
times in the subtitle packets if needed).

The above considerations are not specific to NUT.


Index:
------

Note: With realtime streaming, there is no end, so no index there either.
Index MAY only be repeated after main headers.
If an index is written anywhere in the file, it MUST be written at end of
file as well.


Info:
-----

If an info packet is stored anywhere then a muxer MUST also store an identical
info packet after every main-stream-header set.

If a demuxer has seen several info packets with the same chapter_id and
stream_id then it MUST ignore all but the one with the highest position in
the file.

Demuxers SHOULD NOT search the whole file for info packets.

demuxer (non-normative):
------------------------

In the absence of a valid header at the beginning, players SHOULD search for
backup headers starting at offset 2^x; for each x players SHOULD end their
search at a particular offset when any startcode (including the syncpoint
startcode) is found.


Seeking without an index (non-normative):
-----------------------------------------
A. backward seeking
    1. Perform a binary search on the syncpoint timestamps finding the one
    which is largest and <= the target timestamp.
B. forward seeking
    1a. Perform a binary search on the syncpoint timestamps finding the one
    which is smallest and >= the target timestamp.
    1b. Perform a binary search on the syncpoint back pointers finding the
    smallest one which has a back pointer >= the position found in 1.
2. Follow the back pointer to the corresponding syncpoint.

Alternatively a demuxer can search for a shorter back pointer (which ensures
that keyframes in all streams are closer together) before 2.
One way to do this for backward seeking is:
If the back pointer is longer than the demuxer wants, step back by half the
pointer, search for another syncpoint and repeat until either the pointer is
short enough or the search went too far.


Seeking with an index (non-normative):
--------------------------------------
The demuxer only has to find the appropriate keyframe in the index and
start demuxing from the previous syncpoint.

Note, more complicated seeking methods exist which are capable of quickly
seeking to the optimal point in the presence of an index even if only a
subset of all streams is active.

Note2, A demuxer might wish to favor a syncpoint which has keyframes
in all active streams shortly afterwards instead of one where they are
distant.

A muxer SHOULD place syncpoints so that that simple low complexity seeking
works with fine granularity. That is, syncpoints should be placed prior
to keyframes instead of non-keyframes and with high enough frequency
(once per second unless there are no keyframes between this and the previous
syncpoint).

Encoders SHOULD place keyframes so that the number of points where all
streams have a keyframe at the same time is maximized. This ensures that
seeking (complicated or not) does not need to demux and decode significant
amounts of data to reach a point where a presentable frame for each stream
is available after seeking.


Semantic requirements:
======================

If more than one stream of a given stream class is present, each one SHOULD
have info tags specifying disposition, and if applicable, language.
It often highly improves usability and is therefore strongly encouraged.

A demuxer MUST NOT demux a stream which contains more than one stream, or which
is wrapped in a structure to facilitate more than one stream or otherwise
duplicate the role of a container. Any such file is to be considered invalid.
For example Vorbis in Ogg in NUT is invalid, as is
mpegvideo + mpegaudio in MPEG-PS/TS in NUT or dvvideo + dvaudio in DV in NUT.

A demuxer MUST NOT demux a NUT frame containing anything else than exactly a
single codec frame. A muxer MUST NOT store anything except exactly 1 single
codec frame per NUT frame.
For RAW audio up to 4096 samples shall be considered 1 codec frame, the actual
number of samples MAY vary between NUT frames.
For raw video a codec frame is one video picture.


Sample code (Public Domain, & untested):
========================================

typedef BufferContext{
    uint8_t *buf;
    uint8_t *buf_ptr;
}BufferContext;

static inline uint64_t get_bytes(BufferContext *bc, int count){
    uint64_t val=0;

    assert(count>0 && count<9);

    for(i=0; i<count; i++){
        val <<=8;
        val += *(bc->buf_ptr++);
    }

    return val;
}

static inline void put_bytes(BufferContext *bc, int count, uint64_t val){
    uint64_t val=0;

    assert(count>0 && count<9);

    for(i=count-1; i>=0; i--){
        *(bc->buf_ptr++)= val >> (8*i);
    }

    return val;
}

static inline uint64_t get_v(BufferContext *bc){
    uint64_t val= 0;

    for(; space_left(bc) > 0; ){
        int tmp= *(bc->buf_ptr++);
        if(tmp&0x80)
            val= (val<<7) + tmp - 0x80;
        else
            return (val<<7) + tmp;
    }

    return -1;
}

static inline int put_v(BufferContext *bc, uint64_t val){
    int i;

    if(space_left(bc) < 9) return -1;

    val &= 0x7FFFFFFFFFFFFFFFULL; // FIXME: Can only encode up to 63 bits ATM.
    for(i=7; ; i+=7){
        if(val>>i == 0) break;
    }

    for(i-=7; i>0; i-=7){
        *(bc->buf_ptr++)= 0x80 | (val>>i);
    }
    *(bc->buf_ptr++)= val&0x7F;

    return 0;
}

static int64_t get_dts(int64_t pts, int64_t *pts_cache, int delay, int reset){
    if(reset) memset(pts_cache, -1, delay*sizeof(int64_t));

    while(delay--){
        int64_t t= pts_cache[delay];
        if(t < pts){
            pts_cache[delay]= pts;
            pts= t;
        }
    }

    return pts;
}



Authors:
========

Folks from the MPlayer developers mailing list (http://www.mplayerhq.hu/).
Authors in alphabetical order: (FIXME! Tell us if we left you out)
    Beregszaszi, Alex        (alex@fsn.hu)
    Bunkus, Moritz           (moritz@bunkus.org)
    Diedrich, Tobias         (ranma+mplayer@tdiedrich.de)
    Felker, Rich             (dalias@aerifal.cx)
    Franz, Fabian            (FabianFranz@gmx.de)
    Gereoffy, Arpad          (arpi@thot.banki.hu)
    Hess, Andreas            (jaska@gmx.net)
    Niedermayer, Michael     (michaelni@gmx.at)
    Shimon, Oded             (ods15@ods15.dyndns.org)
]#
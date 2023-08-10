#!/usr/bin/luajit
local ffi = require('ffi')

-- https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/
-- https://commons.wikimedia.org/wiki/File:JPG_Test.jpg
-- bottom more images!

local libecore = ffi.load('ecore.so')
local libecore_evas = ffi.load('ecore_evas.so')
local libecore_file = ffi.load('ecore_file.so')
local libevas = ffi.load('evas.so')

ffi.cdef([[
typedef struct Ecore_Evas Ecore_Evas;
typedef struct Evas Evas;
typedef struct Evas_Object Evas_Object;
typedef struct Ecore_Timer Ecore_Timer;
typedef int Evas_Coord;
typedef void (*Ecore_Evas_Event_Cb) (Ecore_Evas *);
typedef int Evas_Load_Error;
typedef unsigned char Eina_Bool;
typedef struct Ecore_File_Monitor Ecore_File_Monitor;
typedef int Ecore_File_Event;
typedef void (*Ecore_File_Monitor_Cb)(void *, Ecore_File_Monitor *, Ecore_File_Event, const char *);
typedef void (*Evas_Object_Event_Cb)(void *, Evas *, Evas_Object *, void *);
typedef struct Evas_Modifier Evas_Modifier;
typedef struct Evas_Lock Evas_Lock;
typedef struct Evas_Device Evas_Device;
typedef int Evas_Event_Flags;
typedef int Evas_Font_Size;
typedef Eina_Bool (*Ecore_Task_Cb)(void *);

typedef struct {
	int x;
	int y;
} Evas_Point;

typedef struct {
	Evas_Coord x;
	Evas_Coord y;
} Evas_Coord_Point;

typedef struct {
	Evas_Point output;
	Evas_Coord_Point canvas;
} Evas_Position;

typedef enum {
	EVAS_CALLBACK_MOUSE_DOWN = 2,
	EVAS_CALLBACK_MOUSE_UP = 3,
	EVAS_CALLBACK_MOUSE_MOVE = 4,
	EVAS_CALLBACK_MOUSE_WHEEL = 5,
	EVAS_CALLBACK_KEY_DOWN = 10,
	EVAS_CALLBACK_IMAGE_PRELOADED = 22,
} Evas_Callback_Type;

typedef enum {
	EMILE_COLORSPACE_ARGB8888,
} Evas_Colorspace;

typedef struct {
	int button;
	Evas_Point output;
	Evas_Coord_Point canvas;
} Evas_Event_Mouse_Down;

typedef Evas_Event_Mouse_Down Evas_Event_Mouse_Up;

typedef struct {
	int buttons;
	Evas_Position cur;
} Evas_Event_Mouse_Move;

typedef struct {
	int direction;
	int z;
} Evas_Event_Mouse_Wheel;

typedef struct {
	char *keyname;
	void *data;
	Evas_Modifier *modifiers;
	Evas_Lock *locks;

	const char *key;
	const char *string;
	const char *compose;
	unsigned int timestamp;
	Evas_Event_Flags event_flags;
	Evas_Device *dev;

	unsigned int keycode;
} Evas_Event_Key_Down;

typedef enum {
	EVAS_TEXT_STYLE_SOFT_OUTLINE = 3,
} Evas_Text_Style_Type;

Ecore_Timer *ecore_timer_add(double, Ecore_Task_Cb, const void *);
void *ecore_timer_del(Ecore_Timer *);
void ecore_main_loop_begin(void);
void ecore_main_loop_quit(void);

Ecore_Evas *ecore_evas_new(const char *, int, int, int, int, const char *);
Evas *ecore_evas_get(const Ecore_Evas *);
int ecore_evas_init(void);
int ecore_evas_shutdown(void);
void ecore_evas_callback_resize_set(Ecore_Evas *, Ecore_Evas_Event_Cb);
void ecore_evas_free(Ecore_Evas *);
void ecore_evas_geometry_get(const Ecore_Evas *, int *, int *, int *, int *);
void ecore_evas_name_class_set(Ecore_Evas *, const char *, const char *);
void ecore_evas_show(Ecore_Evas *);
void ecore_evas_title_set(Ecore_Evas *, const char *);

Ecore_File_Monitor *ecore_file_monitor_add(const char *, Ecore_File_Monitor_Cb, void *);
void ecore_file_monitor_del(Ecore_File_Monitor *);

Eina_Bool evas_key_modifier_is_set(const Evas_Modifier *, const char *);
Eina_Bool evas_object_image_animated_get(const Evas_Object *);
Evas_Load_Error evas_object_image_load_error_get(const Evas_Object *);
Evas_Object *evas_object_image_add(Evas *);
Evas_Object *evas_object_rectangle_add(Evas *);
Evas_Object *evas_object_textblock_add(Evas *);
double evas_object_image_animated_frame_duration_get(const Evas_Object *, int, int);
int evas_object_image_animated_frame_count_get(const Evas_Object *);
int evas_object_image_animated_frame_get(Evas_Object *);
void evas_object_color_set(Evas_Object *, int, int, int, int);
void evas_object_event_callback_add(Evas_Object *, Evas_Callback_Type, Evas_Object_Event_Cb, const void *);
void evas_object_focus_set(Evas_Object *, Eina_Bool);
void evas_object_hide(Evas_Object *);
void evas_object_image_animated_frame_set(Evas_Object *, int);
void evas_object_image_colorspace_set(Evas_Object *, Evas_Colorspace);
void evas_object_image_data_set(Evas_Object *, void *);
void evas_object_image_data_update_add(Evas_Object *, int, int, int, int);
void evas_object_image_file_set(Evas_Object *, const char *, const char *);
void evas_object_image_fill_set(Evas_Object *, Evas_Coord, Evas_Coord, Evas_Coord, Evas_Coord);
void evas_object_image_load_scale_down_set(Evas_Object *, int);
void evas_object_image_load_size_set(const Evas_Object *, int, int);
void evas_object_image_preload(Evas_Object *, Eina_Bool);
void evas_object_image_reload(Evas_Object *);
void evas_object_image_size_get(const Evas_Object *, int *, int *);
void evas_object_image_size_set(Evas_Object *, int w, int h);
void evas_object_image_smooth_scale_set(Evas_Object *, Eina_Bool);
void evas_object_move(Evas_Object *, Evas_Coord, Evas_Coord);
void evas_object_resize(Evas_Object *, Evas_Coord, Evas_Coord);
void evas_object_show(Evas_Object *);
void evas_object_textblock_text_markup_set(Evas_Object *, const char *);
]])

local libavf, libavutil, libsws
local have_ffmpeg = pcall(function()
	libavf = ffi.load('libavformat.so')
	libavutil = ffi.load('libavutil.so')
	libsws = ffi.load('libswscale.so')
end)

ffi.cdef([[
typedef struct AVDictionary AVDictionary;
typedef struct AVCodecParameters AVCodecParameters;
typedef struct SwsContext SwsContext;

enum AVMediaType {
	AVMEDIA_TYPE_VIDEO = 0,
};

enum AVCodecID {
	AV_CODEC_ID_RAWVIDEO = 13,
};

enum AVPixelFormat {
	AV_PIX_FMT_BGRA = 28,
};

enum AVDiscard {
	AVDISCARD_NONKEY = 32,
	AVDISCARD_ALL = 48,
};

typedef struct {
	int num;
	int den;
} AVRational;

typedef struct {
	const char *name;
} AVCodec;

enum {
	AVERROR_EAGAIN = -11,
};

typedef struct {
	const void *av_class;
	int log_level_offset;
	enum AVMediaType codec_type;
	const AVCodec *codec;
	enum AVCodecID codec_id;
	unsigned int codec_tag;
	void *priv_data;
	void *internal;
	void *opaque;
	int64_t bit_rate;
	int bit_rate_tolerance;
	int global_quality;
	int compression_level;
	int flags;
	int flags2;
	uint8_t *extradata;
	int extradata_size;
	AVRational time_base;
	int ticks_per_frame;
	int delay;
	int width, height;
	int coded_width, coded_height;
	int gop_size;
	enum AVPixelFormat pix_fmt;
} AVCodecContext;

typedef struct {
	const void *av_class;
	int index;
	int id;
	AVCodecParameters *codecpar;
	void *priv_data;
	AVRational time_base;
	int64_t start_time;
	int64_t duration;
	int64_t nb_frames;
	int disposition;
	enum AVDiscard discard;
} AVStream;

typedef struct {
	const void *av_class;
	const void *iformat;
	const void *oformat;
	void *priv_data;
	void *pb;
	int ctx_flags;
	unsigned int nb_streams;
	AVStream **streams;
} AVFormatContext;

typedef struct {
	void *buf;
	int64_t pts;
	int64_t dts;
	uint8_t *data;
	int size;
	int stream_index;
} AVPacket;

typedef struct {
	uint8_t *data[8];
	int linesize[8];
	uint8_t **extended_data;
	int width, height;
	int nb_samples;
	int format;
} AVFrame;

AVCodecContext *avcodec_alloc_context3(const AVCodec *);
AVFrame *av_frame_alloc(void);
AVPacket *av_packet_alloc(void);
int av_find_best_stream(AVFormatContext *, enum AVMediaType, int, int, const AVCodec **, int);
int av_read_frame(AVFormatContext *, AVPacket *);
int avcodec_open2(AVCodecContext *, const AVCodec *, AVDictionary **);
int avcodec_parameters_to_context(AVCodecContext *, const AVCodecParameters *);
int avcodec_receive_frame(AVCodecContext *, AVFrame *);
int avcodec_receive_packet(AVCodecContext *, AVPacket *);
int avcodec_send_frame(AVCodecContext *, const AVFrame *);
int avcodec_send_packet(AVCodecContext *, const AVPacket *);
int avformat_find_stream_info(AVFormatContext *, AVDictionary **);
int avformat_open_input(AVFormatContext **, const char *, const void *, AVDictionary **);
void av_frame_free(AVFrame **);
void av_freep(void *);
void av_packet_free(AVPacket **);
void avcodec_free_context(AVCodecContext **);
void avformat_close_input(AVFormatContext **);

int av_image_alloc(uint8_t *[4], int[4], int, int, enum AVPixelFormat, int);

SwsContext *sws_getContext(int, int, enum AVPixelFormat, int, int, enum AVPixelFormat, int, void *, void *, const double *);
int sws_scale(SwsContext *, const uint8_t *const[], const int[], int, int, uint8_t *const[], const int[]);
int sws_scale_frame(SwsContext *, AVFrame *, const AVFrame *);
void sws_freeContext(SwsContext *);
]])

local M = {}
M.__index = M

local out = ffi.new('int[2]')

function M.new(cls, opts)
	local self = setmetatable({
		bindings = {},
		playlist_current_pos = 0,
		playlist = opts.playlist,
		zoom = 0,
		pan_x = 0,
		pan_y = 0,
		img_w = 0,
		img_h = 0,
		win_w = 0,
		win_h = 0,
	}, cls)

	self:open_window()

	return self
end

function M:set_playlist_current_pos(i)
	self.playlist_current_pos = i
	self:load_file(self.playlist[self.playlist_current_pos])
	-- self:preload_file(self.playlist[self.playlist_current_pos + 1])
end

function M:step_playlist(k)
	local i = self.playlist_current_pos + k
	i = ((i - 1) % #self.playlist + #self.playlist) % #self.playlist + 1
	self:set_playlist_current_pos(i)
end

local on_external_modify_cb = ffi.cast('Ecore_File_Monitor_Cb', function(img_obj)
	libevas.evas_object_image_reload(img_obj)
end)

function M:preload_file(path)
	libevas.evas_object_image_file_set(self.preload_obj, path, nil)
	libevas.evas_object_image_preload(self.preload_obj, false)
end

function M:load_file(path)
	if self.current_file_monitor then
		libecore_file.ecore_file_monitor_del(self.current_file_monitor)
		self.current_file_monitor = nil
	end

	if self.frame_timer then
		libecore.ecore_timer_del(self.frame_timer)
		self.frame_timer = nil
	end

	if path then
		self.current_file_monitor = libecore_file.ecore_file_monitor_add(path, on_external_modify_cb, self.img_obj)
	end

	self.status = ' <color=gray>(loading)</>'
	libecore_evas.ecore_evas_title_set(self.window, path)

	self:update_statusline()

	libevas.evas_object_hide(self.img_obj)
	libevas.evas_object_hide(self.squares_obj)

	libevas.evas_object_image_data_set(self.img_obj, nil)
	self.ffmpeg_data_ref = nil

	libevas.evas_object_image_file_set(self.img_obj, path, nil)
	-- ODS render size.
	libevas.evas_object_image_load_size_set(self.img_obj, self.win_h * 2, self.win_w * 2)
	libevas.evas_object_image_preload(self.img_obj, false)

	-- libevas.evas_object_image_load_region_set
	-- libevas.evas_object_image_load_scale_down_set(self.img_obj, 100);
end

function M:toggle_colorscheme()
	self:set_colorscheme(self.colorscheme == 'light' and 'dark' or 'light')
end

function M:set_colorscheme(colorscheme)
	self.colorscheme = colorscheme

	if self.colorscheme == 'light' then
		libevas.evas_object_color_set(self.bg_obj, 0xff, 0xff, 0xff, 0xff)
	else
		libevas.evas_object_color_set(self.bg_obj, 0, 0, 0, 0xff)
	end

	do
		local even = self.colorscheme == 'light' and 0xed or 0x23
		local odd = self.colorscheme == 'light' and 0xff or 0x00
		local x = self.squares_data

		x[0] = even
		x[1] = even
		x[2] = even
		x[3] = 0xff

		x[4] = odd
		x[5] = odd
		x[6] = odd
		x[7] = 0xff

		x[8] = odd
		x[9] = odd
		x[10] = odd
		x[11] = 0xff

		x[12] = even
		x[13] = even
		x[14] = even
		x[15] = 0xff

		libevas.evas_object_image_data_update_add(self.squares_obj, 0, 0, 2, 2)
	end
end

local bar_h = 22

function M:step_frame()
	local i = libevas.evas_object_image_animated_frame_get(self.img_obj)
	local n = libevas.evas_object_image_animated_frame_count_get(self.img_obj)
	if i < n then
		i = i + 1
	else
		i = 1
	end
	libevas.evas_object_image_animated_frame_set(self.img_obj, i)
end

local function schedule_step_frame(self)
	local i = libevas.evas_object_image_animated_frame_get(self.img_obj)
	local duration = libevas.evas_object_image_animated_frame_duration_get(self.img_obj, i, 0)
	assert(duration > 0)
	self.frame_timer = libecore.ecore_timer_add(duration, self._on_frame_cb, nil)
end

function M:update_statusline()
	local path = self.playlist[self.playlist_current_pos]

	libevas.evas_object_textblock_text_markup_set(
		self.status_obj,
		string.format(
			'<font=monospace font_weight=semibold font_size=14 color=white valign=center ellipsis=1 style=glow glow_color=black outline_color=black shadow_color=black>[%d/%d] (zoom %s %d%%) %s%s</>',
			self.playlist_current_pos,
			#self.playlist,
			self.zoom_mode,
			self.zoom * 100,
			path,
			self.status
		)
	)
end

local function update_view(self)
	self.view_w = math.min(self.img_w * self.zoom, self.win_w)
	self.view_h = math.min(self.img_h * self.zoom, self.win_h)

	local view_x = (self.win_w - self.view_w) / 2
	local view_y = (self.win_h - self.view_h) / 2

	self.pan_hx = (self.img_w - self.view_w / self.zoom) / 2
	self.pan_hy = (self.img_h - self.view_h / self.zoom) / 2

	self.pan_x = math.max(-self.pan_hx, math.min(self.pan_x, self.pan_hx))
	self.pan_y = math.max(-self.pan_hy, math.min(self.pan_y, self.pan_hy))

	do
		libevas.evas_object_move(self.squares_obj, view_x, view_y)
		libevas.evas_object_resize(self.squares_obj, self.view_w, self.view_h)
	end

	do
		libevas.evas_object_move(self.img_obj, view_x, view_y)
		libevas.evas_object_resize(self.img_obj, self.view_w, self.view_h)
		libevas.evas_object_image_fill_set(
			self.img_obj,
			self.pan_x * self.zoom - (self.img_w * self.zoom - self.view_w) / 2,
			self.pan_y * self.zoom - (self.img_h * self.zoom - self.view_h) / 2,
			self.img_w * self.zoom,
			self.img_h * self.zoom
		)
	end
end

local function set_zoom(self, zoom)
	self.zoom = zoom
	update_view(self)

	libevas.evas_object_image_smooth_scale_set(self.img_obj, self.zoom < 5)

	self:update_statusline()
end

local function update_auto_zoom(self)
	if self.zoom_mode == 'fit' then
		local tmp = math.min(self.win_w / self.img_w, self.win_h / self.img_h)
		tmp = math.min(tmp, 1)
		set_zoom(self, tmp)
	end
end

local function load_file_with_ffmpeg(self, path)
	assert(path)

	local ic_ref = ffi.gc(ffi.new('AVFormatContext *[1]'), libavf.avformat_close_input)
	if libavf.avformat_open_input(ic_ref, path, nil, nil) ~= 0 then
		return
	end
	local ic = ic_ref[0]
	assert(libavf.avformat_find_stream_info(ic, nil) == 0)

	local codec_ref = ffi.new('const AVCodec *[1]')
	local stream_index = libavf.av_find_best_stream(ic, libavf.AVMEDIA_TYPE_VIDEO, -1, -1, codec_ref, 0)
	if stream_index < 0 then
		return
	end
	local codec = codec_ref[0]

	for i = 0, stream_index - 1 do
		ic.streams[stream_index].discard = i == stream_index and libavf.AVDISCARD_NONKEY or libavf.AVDISCARD_ALL
	end

	local decoder_ctx = libavf.avcodec_alloc_context3(codec)
	assert(decoder_ctx ~= nil)
	local decoder_ctx_ref = ffi.gc(ffi.new('AVCodecContext *[1]', decoder_ctx), libavf.avcodec_free_context)

	local stream = ic.streams[stream_index]
	assert(libavf.avcodec_parameters_to_context(decoder_ctx, stream.codecpar) == 0)
	assert(libavf.avcodec_open2(decoder_ctx, codec, nil) == 0)

	local packet = libavf.av_packet_alloc()
	assert(packet ~= nil)
	local packet_ref = ffi.gc(ffi.new('AVPacket *[1]', packet), libavf.av_packet_free)

	local frame = libavf.av_frame_alloc()
	assert(frame ~= nil)
	local frame_ref = ffi.gc(ffi.new('AVFrame *[1]', frame), libavf.av_frame_free)

	while libavf.av_read_frame(ic, packet) == 0 do
		if packet.stream_index ~= stream_index then
			goto continue
		end

		assert(libavf.avcodec_send_packet(decoder_ctx, packet) == 0)

		local rc = libavf.avcodec_receive_frame(decoder_ctx, frame)
		if rc == libavf.AVERROR_EAGAIN then
			goto continue
		end
		assert(rc == 0)
		-- assert(frame.format ~= libavf.AV_PIX_FMT_BGRA)

		local sws_ctx = ffi.gc(
			libsws.sws_getContext(
				frame.width,
				frame.height,
				frame.format,
				frame.width,
				frame.height,
				libavf.AV_PIX_FMT_BGRA,
				0,
				nil,
				nil,
				nil
			),
			libsws.sws_freeContext
		)
		assert(sws_ctx ~= nil)

		local dst_data = ffi.gc(ffi.new('uint8_t *[4]'), libavf.av_freep)
		local dst_linesize = ffi.new('int[4]')

		self.ffmpeg_data_ref = dst_data

		local dst_size = libavutil.av_image_alloc(
			dst_data,
			dst_linesize,
			frame.width,
			frame.height,
			libavf.AV_PIX_FMT_BGRA,
			32 -- sws_scale() writes out of bounds if <32.
		)
		assert(dst_size >= 0)

		libsws.sws_scale(
			sws_ctx,
			ffi.cast('void *', frame.data),
			ffi.cast('void *', frame.linesize),
			0,
			frame.height,
			dst_data,
			dst_linesize
		)

		self.img_w, self.img_h = frame.width, frame.height

		libevas.evas_object_image_data_set(self.img_obj, nil)
		libevas.evas_object_image_size_set(self.img_obj, frame.width, frame.height)
		libevas.evas_object_image_colorspace_set(self.img_obj, libevas.EMILE_COLORSPACE_ARGB8888)
		libevas.evas_object_image_data_set(self.img_obj, dst_data[0])
		libevas.evas_object_image_data_update_add(self.img_obj, 0, 0, frame.width, frame.height)

		do
			return
		end
		::continue::
	end
end

local function on_loaded(self)
	libevas.evas_object_image_size_get(self.img_obj, out, out + 1)
	self.img_w, self.img_h = out[0], out[1]

	local ok = libevas.evas_object_image_load_error_get(self.img_obj) == 0

	if not ok and have_ffmpeg then
		local path = self.playlist[self.playlist_current_pos]
		if path then
			load_file_with_ffmpeg(self, path)
		end

		ok = libevas.evas_object_image_load_error_get(self.img_obj) == 0
	end

	self.status = ok and '' or ' <color=red>(error)</>'

	if libevas.evas_object_image_animated_get(self.img_obj) == 1 then
		schedule_step_frame(self)
	end

	update_auto_zoom(self)
	update_view(self)

	libevas.evas_object_show(self.img_obj)
	libevas.evas_object_show(self.squares_obj)

	self:update_statusline()

	collectgarbage()
end

local function parse_binding(s)
	local mods = {
		Shift = false,
		Control = false,
	}
	while true do
		local mod_name, rest = string.match(s, '^([^+]+)+(.+)$')
		if not rest then
			return {
				mods = mods,
				detail = s,
			}
		end
		mods[mod_name] = true
		s = rest
	end
end

function M:add_key_binding(key, handler)
	assert(type(handler) == 'function')

	local binding = parse_binding(key)
	self.bindings[handler] = binding

	local x = binding.detail
	self.bindings[x] = self.bindings[x] or {}
	self.bindings[x][handler] = binding
end

function M:add_key_bindings(t)
	for key, handler in pairs(t) do
		if type(handler) == 'string' then
			handler = t[handler]
		end
		self:add_key_binding(key, handler)
	end
end

function M:remove_key_binding(key, handler)
	local binding = self.bindings[handler]

	if not binding then
		return
	end

	self.bindings[handler] = nil
	self.bindings[binding.detail][handler] = nil
end

function M:set_zoom_to_fit()
	self.zoom_mode = 'fit'
	update_auto_zoom(self)
end

function M:set_manual_zoom(zoom)
	self.zoom_mode = 'manual'
	set_zoom(self, zoom)
end

local function on_resize(self)
	libecore_evas.ecore_evas_geometry_get(self.window, nil, nil, out, out + 1)
	self.win_w, self.win_h = out[0], out[1]

	update_auto_zoom(self)
	update_view(self)

	do
		libevas.evas_object_resize(self.bg_obj, self.win_w, self.win_h)
	end

	do
		libevas.evas_object_move(self.status_obj, 0, self.win_h - bar_h)
		libevas.evas_object_resize(self.status_obj, self.win_w, bar_h)
	end
end

function M:set_pan(x, y)
	self.pan_x, self.pan_y = x, y
	update_view(self)
end

function M:step_pan(x, y)
	local step_x, step_y = self.win_w / self.zoom / 10, self.win_h / self.zoom / 10
	self:set_pan(self.pan_x + step_x * x, self.pan_y + step_y * y)
end

function M:close()
	-- FIXME:
	-- libecore_evas.ecore_evas_free(self.window)
	libecore.ecore_main_loop_quit()
end

function M:open_window()
	do
		self.window = libecore_evas.ecore_evas_new(nil, 0, 0, 800, 600, nil)
		assert(self.window ~= nil)

		libecore_evas.ecore_evas_name_class_set(self.window, 'Minim', 'Minim')

		libecore_evas.ecore_evas_callback_resize_set(self.window, function()
			on_resize(self)
		end)

		libecore_evas.ecore_evas_show(self.window)
	end

	local canvas = libecore_evas.ecore_evas_get(self.window)

	do
		self.bg_obj = libevas.evas_object_rectangle_add(canvas)

		libevas.evas_object_move(self.bg_obj, 0, 0)
		libevas.evas_object_show(self.bg_obj)
		libevas.evas_object_focus_set(self.bg_obj, true)
	end

	do
		self.squares_obj = libevas.evas_object_image_add(canvas)
		self.squares_data = ffi.new('uint8_t[?]', 2 * 2 * 4)

		libevas.evas_object_image_colorspace_set(self.squares_obj, libevas.EMILE_COLORSPACE_ARGB8888)
		libevas.evas_object_image_fill_set(self.squares_obj, 0, 0, 20, 20)
		libevas.evas_object_image_size_set(self.squares_obj, 2, 2)
		libevas.evas_object_image_data_set(self.squares_obj, self.squares_data)
		libevas.evas_object_image_smooth_scale_set(self.squares_obj, false)
		libevas.evas_object_show(self.squares_obj)
	end

	do
		self.img_obj = libevas.evas_object_image_add(canvas)

		libevas.evas_object_event_callback_add(self.img_obj, libevas.EVAS_CALLBACK_IMAGE_PRELOADED, function()
			on_loaded(self)
		end, nil)
	end

	do
		self.preload_obj = libevas.evas_object_image_add(canvas)
	end

	do
		self.status_obj = libevas.evas_object_textblock_add(canvas)

		libevas.evas_object_show(self.status_obj)
	end

	self._on_frame_cb = ffi.cast('Ecore_Task_Cb', function()
		self:step_frame()
		schedule_step_frame(self)
		return false -- One-shot timer.
	end)

	self:set_zoom_to_fit()
	self:set_playlist_current_pos(1)
	self:set_colorscheme('dark')

	self:add_key_bindings({
		q = function()
			self:close()
		end,
		b = function()
			self:toggle_colorscheme()
		end,
		n = function()
			self:step_playlist(1)
		end,
		N = function()
			self:step_playlist(-1)
		end,
		p = function()
			self:step_playlist(-1)
		end,
		space = 'n',
		['Shift+space'] = 'p',
		f = function()
			self:set_zoom_to_fit()
		end,
		equal = function()
			self:set_manual_zoom(1)
		end,
		plus = function()
			self:set_manual_zoom(self.zoom * 1.1)
		end,
		minus = function()
			self:set_manual_zoom(self.zoom / 1.1)
		end,
		Left = function()
			self:step_pan(1, 0)
		end,
		Down = function()
			self:step_pan(0, -1)
		end,
		Up = function()
			self:step_pan(0, 1)
		end,
		Right = function()
			self:step_pan(-1, 0)
		end,
		['Shift+Left'] = function()
			self:step_pan(math.huge, 0)
		end,
		['Shift+Down'] = function()
			self:step_pan(0, -math.huge)
		end,
		['Shift+Up'] = function()
			self:step_pan(0, math.huge)
		end,
		['Shift+Right'] = function()
			self:step_pan(-math.huge, 0)
		end,
		h = 'Left',
		j = 'Down',
		k = 'Up',
		l = 'Right',
		['Shift+H'] = 'Shift+Left',
		['Shift+J'] = 'Shift+Down',
		['Shift+K'] = 'Shift+Up',
		['Shift+L'] = 'Shift+Right',
		t = function()
			-- TODO: thumbnails
		end,
		TAB = function()
			-- TODO: thumbnail mode vs view mode
		end,
	})

	local cast = function(fn)
		return ffi.cast('Evas_Object_Event_Cb', fn)
	end

	local handle_mouse_down_cb = cast(function(_, _, _, event)
		local event = ffi.cast('Evas_Event_Mouse_Down &', event)
		if event.button == 2 then
			self.pan_follows_mouse = not self.pan_follows_mouse
		elseif event.button == 1 or event.button == 3 then
			self.pan_follows_mouse = false
			self.pan_drag = true
			self.pan_drag_x = self.pan_x + (self.win_w / 2 - event.canvas.x) / self.zoom
			self.pan_drag_y = self.pan_y + (self.win_h / 2 - event.canvas.y) / self.zoom
		end
	end)

	local handle_mouse_up_cb = cast(function(_, _, _, event)
		local event = ffi.cast('Evas_Event_Mouse_Up &', event)
		if event.button == 1 or event.button == 3 then
			self.pan_drag = false
		end
	end)

	local handle_mouse_move_cb = cast(function(_, _, _, event)
		local event = ffi.cast('Evas_Event_Mouse_Move &', event)
		if self.pan_follows_mouse then
			self:set_pan(
				self.pan_hx * (1 - 2 * event.cur.canvas.x / self.win_w),
				self.pan_hy * (1 - 2 * event.cur.canvas.y / self.win_h)
			)
		elseif self.pan_drag then
			self:set_pan(
				self.pan_drag_x - (self.win_w / 2 - event.cur.canvas.x) / self.zoom,
				self.pan_drag_y - (self.win_h / 2 - event.cur.canvas.y) / self.zoom
			)
		end
	end)

	local handle_mouse_wheel_cb = cast(function(_, _, _, event)
		local event = ffi.cast('Evas_Event_Mouse_Wheel &', event)
		if event.z < 0 then
			self:set_manual_zoom(self.zoom * 1.1)
		else
			self:set_manual_zoom(self.zoom / 1.1)
		end
	end)

	local handle_key_down_cb = cast(function(_, _, _, event)
		local event = ffi.cast('Evas_Event_Key_Down &', event)
		local detail = ffi.string(event.key)

		local handled = false

		for handler, binding in pairs(self.bindings[detail] or {}) do
			local ok = true

			for mod_name, state in pairs(binding.mods) do
				ok = ok and libevas.evas_key_modifier_is_set(event.modifiers, mod_name) == (state and 1 or 0)
			end

			if ok then
				handler()
				handled = true
			end
		end

		if not handled then
			print(string.format('Unhandled key %s', detail))
		end
	end)

	for _, obj in ipairs({ self.bg_obj, self.img_obj, self.status_obj }) do
		libevas.evas_object_event_callback_add(obj, libevas.EVAS_CALLBACK_MOUSE_DOWN, handle_mouse_down_cb, nil)
		libevas.evas_object_event_callback_add(obj, libevas.EVAS_CALLBACK_MOUSE_UP, handle_mouse_up_cb, nil)
		libevas.evas_object_event_callback_add(obj, libevas.EVAS_CALLBACK_MOUSE_MOVE, handle_mouse_move_cb, nil)
		libevas.evas_object_event_callback_add(obj, libevas.EVAS_CALLBACK_MOUSE_WHEEL, handle_mouse_wheel_cb, nil)
		libevas.evas_object_event_callback_add(obj, libevas.EVAS_CALLBACK_KEY_DOWN, handle_key_down_cb, nil)
	end
end

assert(libecore_evas.ecore_evas_init() > 0)

M:new({
	playlist = { ... },
})

libecore.ecore_main_loop_begin()

libecore_evas.ecore_evas_shutdown()

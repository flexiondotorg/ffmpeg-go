package ffmpeg_test

import (
	"testing"

	"github.com/csnewman/ffmpeg-go"
	"github.com/stretchr/testify/assert"
)

func TestVersions(t *testing.T) {
	// FFmpeg 7.1: version 61.16.101 = 0x3D1065 = 4002661
	assert.Equal(t, 4002661, int(ffmpeg.AVCodecVersion()), "AVCodec version should match expected")
	assert.Equal(t, ffmpeg.LIBAVCodecVersionInt, int(ffmpeg.AVCodecVersion()), "AVCodec version func and const should match")
}

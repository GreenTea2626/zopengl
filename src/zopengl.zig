const std = @import("std");
const assert = std.debug.assert;

const options = @import("zopengl_options");

comptime {
    @setEvalBranchQuota(20_000);
    _ = std.testing.refAllDeclsRecursive(@This());
}

pub const bindings = @import("bindings.zig");
pub const wrapper = @import("wrapper.zig").Wrap(bindings);

pub const LoaderFn = *const fn ([*:0]const u8) callconv(.c) ?*const anyopaque;

pub const Extension = enum {
    KHR_debug,
    //
    EXT_copy_texture,
    //
    NV_bindless_texture,
    NV_shader_buffer_load,
};

pub const EsExtension = enum {
    OES_vertex_array_object,
    //
    KHR_debug,
};

//--------------------------------------------------------------------------------------------------
//
// Functions for loading OpenGL function pointers
//
//--------------------------------------------------------------------------------------------------
pub fn loadCoreProfile(loader: LoaderFn, major: u32, minor: u32) void {
    const ver = 10 * major + minor;

    assert(major >= 1 and major <= 4);
    assert(minor >= 0 and minor <= 6);
    assert(ver >= 10 and ver <= 46);

    loaderFunc = loader;

    // OpenGL 1.0
    if (ver >= 10) {
        load("glCullFace", .{&bindings.cullFace});
        load("glFrontFace", .{&bindings.frontFace});
        load("glHint", .{&bindings.hint});
        load("glLineWidth", .{&bindings.lineWidth});
        load("glPointSize", .{&bindings.pointSize});
        load("glPolygonMode", .{&bindings.polygonMode});
        load("glScissor", .{&bindings.scissor});
        load("glTexParameterf", .{&bindings.texParameterf});
        load("glTexParameterfv", .{&bindings.texParameterfv});
        load("glTexParameteri", .{&bindings.texParameteri});
        load("glTexParameteriv", .{&bindings.texParameteriv});
        load("glTexImage1D", .{&bindings.texImage1D});
        load("glTexImage2D", .{&bindings.texImage2D});
        load("glDrawBuffer", .{&bindings.drawBuffer});
        load("glClear", .{&bindings.clear});
        load("glClearColor", .{&bindings.clearColor});
        load("glClearStencil", .{&bindings.clearStencil});
        load("glClearDepth", .{&bindings.clearDepth});
        load("glStencilMask", .{&bindings.stencilMask});
        load("glColorMask", .{&bindings.colorMask});
        load("glDepthMask", .{&bindings.depthMask});
        load("glDisable", .{&bindings.disable});
        load("glEnable", .{&bindings.enable});
        load("glFinish", .{&bindings.finish});
        load("glFlush", .{&bindings.flush});
        load("glBlendFunc", .{&bindings.blendFunc});
        load("glLogicOp", .{&bindings.logicOp});
        load("glStencilFunc", .{&bindings.stencilFunc});
        load("glStencilOp", .{&bindings.stencilOp});
        load("glDepthFunc", .{&bindings.depthFunc});
        load("glPixelStoref", .{&bindings.pixelStoref});
        load("glPixelStorei", .{&bindings.pixelStorei});
        load("glReadBuffer", .{&bindings.readBuffer});
        load("glReadPixels", .{&bindings.readPixels});
        load("glGetBooleanv", .{&bindings.getBooleanv});
        load("glGetDoublev", .{&bindings.getDoublev});
        load("glGetError", .{&bindings.getError});
        load("glGetFloatv", .{&bindings.getFloatv});
        load("glGetIntegerv", .{&bindings.getIntegerv});
        load("glGetString", .{&bindings.getString});
        load("glGetTexImage", .{&bindings.getTexImage});
        load("glGetTexParameterfv", .{&bindings.getTexParameterfv});
        load("glGetTexParameteriv", .{&bindings.getTexParameteriv});
        load("glGetTexLevelParameterfv", .{&bindings.getTexLevelParameterfv});
        load("glGetTexLevelParameteriv", .{&bindings.getTexLevelParameteriv});
        load("glIsEnabled", .{&bindings.isEnabled});
        load("glDepthRange", .{&bindings.depthRange});
        load("glViewport", .{&bindings.viewport});
    }

    // OpenGL 1.1
    if (ver >= 11) {
        load("glDrawArrays", .{&bindings.drawArrays});
        load("glDrawElements", .{&bindings.drawElements});
        load("glPolygonOffset", .{&bindings.polygonOffset});
        load("glCopyTexImage1D", .{&bindings.copyTexImage1D});
        load("glCopyTexImage2D", .{&bindings.copyTexImage2D});
        load("glCopyTexSubImage1D", .{&bindings.copyTexSubImage1D});
        load("glCopyTexSubImage2D", .{&bindings.copyTexSubImage2D});
        load("glTexSubImage1D", .{&bindings.texSubImage1D});
        load("glTexSubImage2D", .{&bindings.texSubImage2D});
        load("glBindTexture", .{&bindings.bindTexture});
        load("glDeleteTextures", .{&bindings.deleteTextures});
        load("glGenTextures", .{&bindings.genTextures});
        load("glIsTexture", .{&bindings.isTexture});
    }

    // OpenGL 1.2
    if (ver >= 12) {
        load("glDrawRangeElements", .{&bindings.drawRangeElements});
        load("glTexImage3D", .{&bindings.texImage3D});
        load("glTexSubImage3D", .{&bindings.texSubImage3D});
        load("glCopyTexSubImage3D", .{&bindings.copyTexSubImage3D});
    }

    // OpenGL 1.3
    if (ver >= 13) {
        load("glActiveTexture", .{&bindings.activeTexture});
        load("glSampleCoverage", .{&bindings.sampleCoverage});
        load("glCompressedTexImage3D", .{&bindings.compressedTexImage3D});
        load("glCompressedTexImage2D", .{&bindings.compressedTexImage2D});
        load("glCompressedTexImage1D", .{&bindings.compressedTexImage1D});
        load("glCompressedTexSubImage3D", .{&bindings.compressedTexSubImage3D});
        load("glCompressedTexSubImage2D", .{&bindings.compressedTexSubImage2D});
        load("glCompressedTexSubImage1D", .{&bindings.compressedTexSubImage1D});
        load("glGetCompressedTexImage", .{&bindings.getCompressedTexImage});
    }

    // OpenGL 1.4
    if (ver >= 14) {
        load("glBlendFuncSeparate", .{&bindings.blendFuncSeparate});
        load("glMultiDrawArrays", .{&bindings.multiDrawArrays});
        load("glMultiDrawElements", .{&bindings.multiDrawElements});
        load("glPointParameterf", .{&bindings.pointParameterf});
        load("glPointParameterfv", .{&bindings.pointParameterfv});
        load("glPointParameteri", .{&bindings.pointParameteri});
        load("glPointParameteriv", .{&bindings.pointParameteriv});
        load("glBlendColor", .{&bindings.blendColor});
        load("glBlendEquation", .{&bindings.blendEquation});
    }

    // OpenGL 1.5
    if (ver >= 15) {
        load("glGenQueries", .{&bindings.genQueries});
        load("glDeleteQueries", .{&bindings.deleteQueries});
        load("glIsQuery", .{&bindings.isQuery});
        load("glBeginQuery", .{&bindings.beginQuery});
        load("glEndQuery", .{&bindings.endQuery});
        load("glGetQueryiv", .{&bindings.getQueryiv});
        load("glGetQueryObjectiv", .{&bindings.getQueryObjectiv});
        load("glGetQueryObjectuiv", .{&bindings.getQueryObjectuiv});
        load("glBindBuffer", .{&bindings.bindBuffer});
        load("glDeleteBuffers", .{&bindings.deleteBuffers});
        load("glGenBuffers", .{&bindings.genBuffers});
        load("glIsBuffer", .{&bindings.isBuffer});
        load("glBufferData", .{&bindings.bufferData});
        load("glBufferSubData", .{&bindings.bufferSubData});
        load("glGetBufferSubData", .{&bindings.getBufferSubData});
        load("glMapBuffer", .{&bindings.mapBuffer});
        load("glUnmapBuffer", .{&bindings.unmapBuffer});
        load("glGetBufferParameteriv", .{&bindings.getBufferParameteriv});
        load("glGetBufferPointerv", .{&bindings.getBufferPointerv});
    }

    // OpenGL 2.0
    if (ver >= 20) {
        load("glBlendEquationSeparate", .{&bindings.blendEquationSeparate});
        load("glDrawBuffers", .{&bindings.drawBuffers});
        load("glStencilOpSeparate", .{&bindings.stencilOpSeparate});
        load("glStencilFuncSeparate", .{&bindings.stencilFuncSeparate});
        load("glStencilMaskSeparate", .{&bindings.stencilMaskSeparate});
        load("glAttachShader", .{&bindings.attachShader});
        load("glBindAttribLocation", .{&bindings.bindAttribLocation});
        load("glCompileShader", .{&bindings.compileShader});
        load("glCreateProgram", .{&bindings.createProgram});
        load("glCreateShader", .{&bindings.createShader});
        load("glDeleteProgram", .{&bindings.deleteProgram});
        load("glDeleteShader", .{&bindings.deleteShader});
        load("glDetachShader", .{&bindings.detachShader});
        load("glDisableVertexAttribArray", .{&bindings.disableVertexAttribArray});
        load("glEnableVertexAttribArray", .{&bindings.enableVertexAttribArray});
        load("glGetActiveAttrib", .{&bindings.getActiveAttrib});
        load("glGetActiveUniform", .{&bindings.getActiveUniform});
        load("glGetAttachedShaders", .{&bindings.getAttachedShaders});
        load("glGetAttribLocation", .{&bindings.getAttribLocation});
        load("glGetProgramiv", .{&bindings.getProgramiv});
        load("glGetProgramInfoLog", .{&bindings.getProgramInfoLog});
        load("glGetShaderiv", .{&bindings.getShaderiv});
        load("glGetShaderInfoLog", .{&bindings.getShaderInfoLog});
        load("glGetShaderSource", .{&bindings.getShaderSource});
        load("glGetUniformLocation", .{&bindings.getUniformLocation});
        load("glGetUniformfv", .{&bindings.getUniformfv});
        load("glGetUniformiv", .{&bindings.getUniformiv});
        load("glGetVertexAttribdv", .{&bindings.getVertexAttribdv});
        load("glGetVertexAttribfv", .{&bindings.getVertexAttribfv});
        load("glGetVertexAttribiv", .{&bindings.getVertexAttribiv});
        load("glGetVertexAttribPointerv", .{&bindings.getVertexAttribPointerv});
        load("glIsProgram", .{&bindings.isProgram});
        load("glIsShader", .{&bindings.isShader});
        load("glLinkProgram", .{&bindings.linkProgram});
        load("glShaderSource", .{&bindings.shaderSource});
        load("glUseProgram", .{&bindings.useProgram});
        load("glUniform1f", .{&bindings.uniform1f});
        load("glUniform2f", .{&bindings.uniform2f});
        load("glUniform3f", .{&bindings.uniform3f});
        load("glUniform4f", .{&bindings.uniform4f});
        load("glUniform1i", .{&bindings.uniform1i});
        load("glUniform2i", .{&bindings.uniform2i});
        load("glUniform3i", .{&bindings.uniform3i});
        load("glUniform4i", .{&bindings.uniform4i});
        load("glUniform1fv", .{&bindings.uniform1fv});
        load("glUniform2fv", .{&bindings.uniform2fv});
        load("glUniform3fv", .{&bindings.uniform3fv});
        load("glUniform4fv", .{&bindings.uniform4fv});
        load("glUniform1iv", .{&bindings.uniform1iv});
        load("glUniform2iv", .{&bindings.uniform2iv});
        load("glUniform3iv", .{&bindings.uniform3iv});
        load("glUniform4iv", .{&bindings.uniform4iv});
        load("glUniformMatrix2fv", .{&bindings.uniformMatrix2fv});
        load("glUniformMatrix3fv", .{&bindings.uniformMatrix3fv});
        load("glUniformMatrix4fv", .{&bindings.uniformMatrix4fv});
        load("glValidateProgram", .{&bindings.validateProgram});
        load("glVertexAttrib1d", .{&bindings.vertexAttrib1d});
        load("glVertexAttrib1dv", .{&bindings.vertexAttrib1dv});
        load("glVertexAttrib1f", .{&bindings.vertexAttrib1f});
        load("glVertexAttrib1fv", .{&bindings.vertexAttrib1fv});
        load("glVertexAttrib1s", .{&bindings.vertexAttrib1s});
        load("glVertexAttrib1sv", .{&bindings.vertexAttrib1sv});
        load("glVertexAttrib2d", .{&bindings.vertexAttrib2d});
        load("glVertexAttrib2dv", .{&bindings.vertexAttrib2dv});
        load("glVertexAttrib2f", .{&bindings.vertexAttrib2f});
        load("glVertexAttrib2fv", .{&bindings.vertexAttrib2fv});
        load("glVertexAttrib2s", .{&bindings.vertexAttrib2s});
        load("glVertexAttrib2sv", .{&bindings.vertexAttrib2sv});
        load("glVertexAttrib3d", .{&bindings.vertexAttrib3d});
        load("glVertexAttrib3dv", .{&bindings.vertexAttrib3dv});
        load("glVertexAttrib3f", .{&bindings.vertexAttrib3f});
        load("glVertexAttrib3fv", .{&bindings.vertexAttrib3fv});
        load("glVertexAttrib3s", .{&bindings.vertexAttrib3s});
        load("glVertexAttrib3sv", .{&bindings.vertexAttrib3sv});
        load("glVertexAttrib4Nbv", .{&bindings.vertexAttrib4Nbv});
        load("glVertexAttrib4Niv", .{&bindings.vertexAttrib4Niv});
        load("glVertexAttrib4Nsv", .{&bindings.vertexAttrib4Nsv});
        load("glVertexAttrib4Nub", .{&bindings.vertexAttrib4Nub});
        load("glVertexAttrib4Nubv", .{&bindings.vertexAttrib4Nubv});
        load("glVertexAttrib4Nuiv", .{&bindings.vertexAttrib4Nuiv});
        load("glVertexAttrib4Nusv", .{&bindings.vertexAttrib4Nusv});
        load("glVertexAttrib4bv", .{&bindings.vertexAttrib4bv});
        load("glVertexAttrib4d", .{&bindings.vertexAttrib4d});
        load("glVertexAttrib4dv", .{&bindings.vertexAttrib4dv});
        load("glVertexAttrib4f", .{&bindings.vertexAttrib4f});
        load("glVertexAttrib4fv", .{&bindings.vertexAttrib4fv});
        load("glVertexAttrib4iv", .{&bindings.vertexAttrib4iv});
        load("glVertexAttrib4s", .{&bindings.vertexAttrib4s});
        load("glVertexAttrib4sv", .{&bindings.vertexAttrib4sv});
        load("glVertexAttrib4ubv", .{&bindings.vertexAttrib4ubv});
        load("glVertexAttrib4uiv", .{&bindings.vertexAttrib4uiv});
        load("glVertexAttrib4usv", .{&bindings.vertexAttrib4usv});
        load("glVertexAttribPointer", .{&bindings.vertexAttribPointer});
    }

    // OpenGL 2.1
    if (ver >= 21) {
        load("glUniformMatrix2x3fv", .{&bindings.uniformMatrix2x3fv});
        load("glUniformMatrix3x2fv", .{&bindings.uniformMatrix3x2fv});
        load("glUniformMatrix2x4fv", .{&bindings.uniformMatrix2x4fv});
        load("glUniformMatrix4x2fv", .{&bindings.uniformMatrix4x2fv});
        load("glUniformMatrix3x4fv", .{&bindings.uniformMatrix3x4fv});
        load("glUniformMatrix4x3fv", .{&bindings.uniformMatrix4x3fv});
    }

    // OpenGL 3.0
    if (ver >= 30) {
        load("glColorMaski", .{&bindings.colorMaski});
        load("glGetBooleani_v", .{&bindings.getBooleani_v});
        load("glGetIntegeri_v", .{&bindings.getIntegeri_v});
        load("glEnablei", .{&bindings.enablei});
        load("glDisablei", .{&bindings.disablei});
        load("glIsEnabledi", .{&bindings.isEnabledi});
        load("glBeginTransformFeedback", .{&bindings.beginTransformFeedback});
        load("glEndTransformFeedback", .{&bindings.endTransformFeedback});
        load("glBindBufferRange", .{&bindings.bindBufferRange});
        load("glBindBufferBase", .{&bindings.bindBufferBase});
        load("glTransformFeedbackVaryings", .{&bindings.transformFeedbackVaryings});
        load("glGetTransformFeedbackVarying", .{&bindings.getTransformFeedbackVarying});
        load("glClampColor", .{&bindings.clampColor});
        load("glBeginConditionalRender", .{&bindings.beginConditionalRender});
        load("glEndConditionalRender", .{&bindings.endConditionalRender});
        load("glVertexAttribIPointer", .{&bindings.vertexAttribIPointer});
        load("glGetVertexAttribIiv", .{&bindings.getVertexAttribIiv});
        load("glGetVertexAttribIuiv", .{&bindings.getVertexAttribIuiv});
        load("glVertexAttribI1i", .{&bindings.vertexAttribI1i});
        load("glVertexAttribI2i", .{&bindings.vertexAttribI2i});
        load("glVertexAttribI3i", .{&bindings.vertexAttribI3i});
        load("glVertexAttribI4i", .{&bindings.vertexAttribI4i});
        load("glVertexAttribI1ui", .{&bindings.vertexAttribI1ui});
        load("glVertexAttribI2ui", .{&bindings.vertexAttribI2ui});
        load("glVertexAttribI3ui", .{&bindings.vertexAttribI3ui});
        load("glVertexAttribI4ui", .{&bindings.vertexAttribI4ui});
        load("glVertexAttribI1iv", .{&bindings.vertexAttribI1iv});
        load("glVertexAttribI2iv", .{&bindings.vertexAttribI2iv});
        load("glVertexAttribI3iv", .{&bindings.vertexAttribI3iv});
        load("glVertexAttribI4iv", .{&bindings.vertexAttribI4iv});
        load("glVertexAttribI1uiv", .{&bindings.vertexAttribI1uiv});
        load("glVertexAttribI2uiv", .{&bindings.vertexAttribI2uiv});
        load("glVertexAttribI3uiv", .{&bindings.vertexAttribI3uiv});
        load("glVertexAttribI4uiv", .{&bindings.vertexAttribI4uiv});
        load("glVertexAttribI4bv", .{&bindings.vertexAttribI4bv});
        load("glVertexAttribI4sv", .{&bindings.vertexAttribI4sv});
        load("glVertexAttribI4ubv", .{&bindings.vertexAttribI4ubv});
        load("glVertexAttribI4usv", .{&bindings.vertexAttribI4usv});
        load("glGetUniformuiv", .{&bindings.getUniformuiv});
        load("glBindFragDataLocation", .{&bindings.bindFragDataLocation});
        load("glGetFragDataLocation", .{&bindings.getFragDataLocation});
        load("glUniform1ui", .{&bindings.uniform1ui});
        load("glUniform2ui", .{&bindings.uniform2ui});
        load("glUniform3ui", .{&bindings.uniform3ui});
        load("glUniform4ui", .{&bindings.uniform4ui});
        load("glUniform1uiv", .{&bindings.uniform1uiv});
        load("glUniform2uiv", .{&bindings.uniform2uiv});
        load("glUniform3uiv", .{&bindings.uniform3uiv});
        load("glUniform4uiv", .{&bindings.uniform4uiv});
        load("glTexParameterIiv", .{&bindings.texParameterIiv});
        load("glTexParameterIuiv", .{&bindings.texParameterIuiv});
        load("glGetTexParameterIiv", .{&bindings.getTexParameterIiv});
        load("glGetTexParameterIuiv", .{&bindings.getTexParameterIuiv});
        load("glClearBufferiv", .{&bindings.clearBufferiv});
        load("glClearBufferuiv", .{&bindings.clearBufferuiv});
        load("glClearBufferfv", .{&bindings.clearBufferfv});
        load("glClearBufferfi", .{&bindings.clearBufferfi});
        load("glGetStringi", .{&bindings.getStringi});
        load("glIsRenderbuffer", .{&bindings.isRenderbuffer});
        load("glBindRenderbuffer", .{&bindings.bindRenderbuffer});
        load("glDeleteRenderbuffers", .{&bindings.deleteRenderbuffers});
        load("glGenRenderbuffers", .{&bindings.genRenderbuffers});
        load("glRenderbufferStorage", .{&bindings.renderbufferStorage});
        load("glGetRenderbufferParameteriv", .{&bindings.getRenderbufferParameteriv});
        load("glIsFramebuffer", .{&bindings.isFramebuffer});
        load("glBindFramebuffer", .{&bindings.bindFramebuffer});
        load("glDeleteFramebuffers", .{&bindings.deleteFramebuffers});
        load("glGenFramebuffers", .{&bindings.genFramebuffers});
        load("glCheckFramebufferStatus", .{&bindings.checkFramebufferStatus});
        load("glFramebufferTexture1D", .{&bindings.framebufferTexture1D});
        load("glFramebufferTexture2D", .{&bindings.framebufferTexture2D});
        load("glFramebufferTexture3D", .{&bindings.framebufferTexture3D});
        load("glFramebufferRenderbuffer", .{&bindings.framebufferRenderbuffer});
        load("glGetFramebufferAttachmentParameteriv", .{&bindings.getFramebufferAttachmentParameteriv});
        load("glGenerateMipmap", .{&bindings.generateMipmap});
        load("glBlitFramebuffer", .{&bindings.blitFramebuffer});
        load("glRenderbufferStorageMultisample", .{&bindings.renderbufferStorageMultisample});
        load("glFramebufferTextureLayer", .{&bindings.framebufferTextureLayer});
        load("glMapBufferRange", .{&bindings.mapBufferRange});
        load("glFlushMappedBufferRange", .{&bindings.flushMappedBufferRange});
        load("glBindVertexArray", .{&bindings.bindVertexArray});
        load("glDeleteVertexArrays", .{&bindings.deleteVertexArrays});
        load("glGenVertexArrays", .{&bindings.genVertexArrays});
        load("glIsVertexArray", .{&bindings.isVertexArray});
    }

    // OpenGL 3.1
    if (ver >= 31) {
        load("glDrawArraysInstanced", .{&bindings.drawArraysInstanced});
        load("glDrawElementsInstanced", .{&bindings.drawElementsInstanced});
        load("glTexBuffer", .{&bindings.texBuffer});
        load("glPrimitiveRestartIndex", .{&bindings.primitiveRestartIndex});
        load("glCopyBufferSubData", .{&bindings.copyBufferSubData});
        load("glGetUniformIndices", .{&bindings.getUniformIndices});
        load("glGetActiveUniformsiv", .{&bindings.getActiveUniformsiv});
        load("glGetActiveUniformName", .{&bindings.getActiveUniformName});
        load("glGetUniformBlockIndex", .{&bindings.getUniformBlockIndex});
        load("glGetActiveUniformBlockiv", .{&bindings.getActiveUniformBlockiv});
        load("glGetActiveUniformBlockName", .{&bindings.getActiveUniformBlockName});
        load("glUniformBlockBinding", .{&bindings.uniformBlockBinding});
    }

    // OpenGL 3.2
    if (ver >= 32) {
        load("glDrawElementsBaseVertex", .{&bindings.drawElementsBaseVertex});
        load("glDrawRangeElementsBaseVertex", .{&bindings.drawRangeElementsBaseVertex});
        load("glDrawElementsInstancedBaseVertex", .{&bindings.drawElementsInstancedBaseVertex});
        load("glMultiDrawElementsBaseVertex", .{&bindings.multiDrawElementsBaseVertex});
        load("glProvokingVertex", .{&bindings.provokingVertex});
        load("glFenceSync", .{&bindings.fenceSync});
        load("glIsSync", .{&bindings.isSync});
        load("glDeleteSync", .{&bindings.deleteSync});
        load("glClientWaitSync", .{&bindings.clientWaitSync});
        load("glWaitSync", .{&bindings.waitSync});
        load("glGetInteger64v", .{&bindings.getInteger64v});
        load("glGetSynciv", .{&bindings.getSynciv});
        load("glGetInteger64i_v", .{&bindings.getInteger64i_v});
        load("glGetBufferParameteri64v", .{&bindings.getBufferParameteri64v});
        load("glFramebufferTexture", .{&bindings.framebufferTexture});
        load("glTexImage2DMultisample", .{&bindings.texImage2DMultisample});
        load("glTexImage3DMultisample", .{&bindings.texImage3DMultisample});
        load("glGetMultisamplefv", .{&bindings.getMultisamplefv});
        load("glSampleMaski", .{&bindings.sampleMaski});
    }

    // OpenGL 3.3
    if (ver >= 33) {
        load("glBindFragDataLocationIndexed", .{&bindings.bindFragDataLocationIndexed});
        load("glGetFragDataIndex", .{&bindings.getFragDataIndex});
        load("glGenSamplers", .{&bindings.genSamplers});
        load("glDeleteSamplers", .{&bindings.deleteSamplers});
        load("glIsSampler", .{&bindings.isSampler});
        load("glBindSampler", .{&bindings.bindSampler});
        load("glSamplerParameteri", .{&bindings.samplerParameteri});
        load("glSamplerParameteriv", .{&bindings.samplerParameteriv});
        load("glSamplerParameterf", .{&bindings.samplerParameterf});
        load("glSamplerParameterfv", .{&bindings.samplerParameterfv});
        load("glSamplerParameterIiv", .{&bindings.samplerParameterIiv});
        load("glSamplerParameterIuiv", .{&bindings.samplerParameterIuiv});
        load("glGetSamplerParameteriv", .{&bindings.getSamplerParameteriv});
        load("glGetSamplerParameterIiv", .{&bindings.getSamplerParameterIiv});
        load("glGetSamplerParameterfv", .{&bindings.getSamplerParameterfv});
        load("glGetSamplerParameterIuiv", .{&bindings.getSamplerParameterIuiv});
        load("glQueryCounter", .{&bindings.queryCounter});
        load("glGetQueryObjecti64v", .{&bindings.getQueryObjecti64v});
        load("glGetQueryObjectui64v", .{&bindings.getQueryObjectui64v});
        load("glVertexAttribDivisor", .{&bindings.vertexAttribDivisor});
        load("glVertexAttribP1ui", .{&bindings.vertexAttribP1ui});
        load("glVertexAttribP1uiv", .{&bindings.vertexAttribP1uiv});
        load("glVertexAttribP2ui", .{&bindings.vertexAttribP2ui});
        load("glVertexAttribP2uiv", .{&bindings.vertexAttribP2uiv});
        load("glVertexAttribP3ui", .{&bindings.vertexAttribP3ui});
        load("glVertexAttribP3uiv", .{&bindings.vertexAttribP3uiv});
        load("glVertexAttribP4ui", .{&bindings.vertexAttribP4ui});
        load("glVertexAttribP4uiv", .{&bindings.vertexAttribP4uiv});
    }

    // OpenGL 4.0
    if (ver >= 40) {
        load("glMinSampleShading", .{&bindings.minSampleShading});
        load("glBlendEquationi", .{&bindings.blendEquationi});
        load("glBlendEquationSeparatei", .{&bindings.blendEquationSeparatei});
        load("glBlendFunci", .{&bindings.blendFunci});
        load("glBlendFuncSeparatei", .{&bindings.blendFuncSeparatei});
        load("glDrawArraysIndirect", .{&bindings.drawArraysIndirect});
        load("glDrawElementsIndirect", .{&bindings.drawElementsIndirect});
        load("glUniform1d", .{&bindings.uniform1d});
        load("glUniform2d", .{&bindings.uniform2d});
        load("glUniform3d", .{&bindings.uniform3d});
        load("glUniform4d", .{&bindings.uniform4d});
        load("glUniform1dv", .{&bindings.uniform1dv});
        load("glUniform2dv", .{&bindings.uniform2dv});
        load("glUniform3dv", .{&bindings.uniform3dv});
        load("glUniform4dv", .{&bindings.uniform4dv});
        load("glUniformMatrix2dv", .{&bindings.uniformMatrix2dv});
        load("glUniformMatrix3dv", .{&bindings.uniformMatrix3dv});
        load("glUniformMatrix4dv", .{&bindings.uniformMatrix4dv});
        load("glUniformMatrix2x3dv", .{&bindings.uniformMatrix2x3dv});
        load("glUniformMatrix2x4dv", .{&bindings.uniformMatrix2x4dv});
        load("glUniformMatrix3x2dv", .{&bindings.uniformMatrix3x2dv});
        load("glUniformMatrix3x4dv", .{&bindings.uniformMatrix3x4dv});
        load("glUniformMatrix4x2dv", .{&bindings.uniformMatrix4x2dv});
        load("glUniformMatrix4x3dv", .{&bindings.uniformMatrix4x3dv});
        load("glGetUniformdv", .{&bindings.getUniformdv});
        load("glGetSubroutineUniformLocation", .{&bindings.getSubroutineUniformLocation});
        load("glGetSubroutineIndex", .{&bindings.getSubroutineIndex});
        load("glGetActiveSubroutineUniformiv", .{&bindings.getActiveSubroutineUniformiv});
        load("glGetActiveSubroutineUniformName", .{&bindings.getActiveSubroutineUniformName});
        load("glGetActiveSubroutineName", .{&bindings.getActiveSubroutineName});
        load("glUniformSubroutinesuiv", .{&bindings.uniformSubroutinesuiv});
        load("glGetUniformSubroutineuiv", .{&bindings.getUniformSubroutineuiv});
        load("glGetProgramStageiv", .{&bindings.getProgramStageiv});
        load("glPatchParameteri", .{&bindings.patchParameteri});
        load("glPatchParameterfv", .{&bindings.patchParameterfv});
        load("glBindTransformFeedback", .{&bindings.bindTransformFeedback});
        load("glDeleteTransformFeedbacks", .{&bindings.deleteTransformFeedbacks});
        load("glGenTransformFeedbacks", .{&bindings.genTransformFeedbacks});
        load("glIsTransformFeedback", .{&bindings.isTransformFeedback});
        load("glPauseTransformFeedback", .{&bindings.pauseTransformFeedback});
        load("glResumeTransformFeedback", .{&bindings.resumeTransformFeedback});
        load("glDrawTransformFeedback", .{&bindings.drawTransformFeedback});
        load("glDrawTransformFeedbackStream", .{&bindings.drawTransformFeedbackStream});
        load("glBeginQueryIndexed", .{&bindings.beginQueryIndexed});
        load("glEndQueryIndexed", .{&bindings.endQueryIndexed});
        load("glGetQueryIndexediv", .{&bindings.getQueryIndexediv});
    }

    // OpenGL 4.1
    if (ver >= 41) {
        load("glReleaseShaderCompiler", .{&bindings.releaseShaderCompiler});
        load("glShaderBinary", .{&bindings.shaderBinary});
        load("glGetShaderPrecisionFormat", .{&bindings.getShaderPrecisionFormat});
        load("glDepthRangef", .{&bindings.depthRangef});
        load("glClearDepthf", .{&bindings.clearDepthf});
        load("glGetProgramBinary", .{&bindings.getProgramBinary});
        load("glProgramBinary", .{&bindings.programBinary});
        load("glProgramParameteri", .{&bindings.programParameteri});
        load("glUseProgramStages", .{&bindings.useProgramStages});
        load("glActiveShaderProgram", .{&bindings.activeShaderProgram});
        load("glCreateShaderProgramv", .{&bindings.createShaderProgramv});
        load("glBindProgramPipeline", .{&bindings.bindProgramPipeline});
        load("glDeleteProgramPipelines", .{&bindings.deleteProgramPipelines});
        load("glGenProgramPipelines", .{&bindings.genProgramPipelines});
        load("glIsProgramPipeline", .{&bindings.isProgramPipeline});
        load("glGetProgramPipelineiv", .{&bindings.getProgramPipelineiv});
        load("glProgramUniform1i", .{&bindings.programUniform1i});
        load("glProgramUniform2i", .{&bindings.programUniform2i});
        load("glProgramUniform3i", .{&bindings.programUniform3i});
        load("glProgramUniform4i", .{&bindings.programUniform4i});
        load("glProgramUniform1ui", .{&bindings.programUniform1ui});
        load("glProgramUniform2ui", .{&bindings.programUniform2ui});
        load("glProgramUniform3ui", .{&bindings.programUniform3ui});
        load("glProgramUniform4ui", .{&bindings.programUniform4ui});
        load("glProgramUniform1f", .{&bindings.programUniform1f});
        load("glProgramUniform2f", .{&bindings.programUniform2f});
        load("glProgramUniform3f", .{&bindings.programUniform3f});
        load("glProgramUniform4f", .{&bindings.programUniform4f});
        load("glProgramUniform1d", .{&bindings.programUniform1d});
        load("glProgramUniform2d", .{&bindings.programUniform2d});
        load("glProgramUniform3d", .{&bindings.programUniform3d});
        load("glProgramUniform4d", .{&bindings.programUniform4d});
        load("glProgramUniform1iv", .{&bindings.programUniform1iv});
        load("glProgramUniform2iv", .{&bindings.programUniform2iv});
        load("glProgramUniform3iv", .{&bindings.programUniform3iv});
        load("glProgramUniform4iv", .{&bindings.programUniform4iv});
        load("glProgramUniform1uiv", .{&bindings.programUniform1uiv});
        load("glProgramUniform2uiv", .{&bindings.programUniform2uiv});
        load("glProgramUniform3uiv", .{&bindings.programUniform3uiv});
        load("glProgramUniform4uiv", .{&bindings.programUniform4uiv});
        load("glProgramUniform1fv", .{&bindings.programUniform1fv});
        load("glProgramUniform2fv", .{&bindings.programUniform2fv});
        load("glProgramUniform3fv", .{&bindings.programUniform3fv});
        load("glProgramUniform4fv", .{&bindings.programUniform4fv});
        load("glProgramUniform1dv", .{&bindings.programUniform1dv});
        load("glProgramUniform2dv", .{&bindings.programUniform2dv});
        load("glProgramUniform3dv", .{&bindings.programUniform3dv});
        load("glProgramUniform4dv", .{&bindings.programUniform4dv});
        load("glProgramUniformMatrix2fv", .{&bindings.programUniformMatrix2fv});
        load("glProgramUniformMatrix3fv", .{&bindings.programUniformMatrix3fv});
        load("glProgramUniformMatrix4fv", .{&bindings.programUniformMatrix4fv});
        load("glProgramUniformMatrix2dv", .{&bindings.programUniformMatrix2dv});
        load("glProgramUniformMatrix3dv", .{&bindings.programUniformMatrix3dv});
        load("glProgramUniformMatrix4dv", .{&bindings.programUniformMatrix4dv});
        load("glProgramUniformMatrix2x3fv", .{&bindings.programUniformMatrix2x3fv});
        load("glProgramUniformMatrix3x2fv", .{&bindings.programUniformMatrix3x2fv});
        load("glProgramUniformMatrix2x4fv", .{&bindings.programUniformMatrix2x4fv});
        load("glProgramUniformMatrix4x2fv", .{&bindings.programUniformMatrix4x2fv});
        load("glProgramUniformMatrix3x4fv", .{&bindings.programUniformMatrix3x4fv});
        load("glProgramUniformMatrix4x3fv", .{&bindings.programUniformMatrix4x3fv});
        load("glProgramUniformMatrix2x3dv", .{&bindings.programUniformMatrix2x3dv});
        load("glProgramUniformMatrix3x2dv", .{&bindings.programUniformMatrix3x2dv});
        load("glProgramUniformMatrix2x4dv", .{&bindings.programUniformMatrix2x4dv});
        load("glProgramUniformMatrix4x2dv", .{&bindings.programUniformMatrix4x2dv});
        load("glProgramUniformMatrix3x4dv", .{&bindings.programUniformMatrix3x4dv});
        load("glProgramUniformMatrix4x3dv", .{&bindings.programUniformMatrix4x3dv});
        load("glValidateProgramPipeline", .{&bindings.validateProgramPipeline});
        load("glGetProgramPipelineInfoLog", .{&bindings.getProgramPipelineInfoLog});
        load("glVertexAttribL1d", .{&bindings.vertexAttribL1d});
        load("glVertexAttribL2d", .{&bindings.vertexAttribL2d});
        load("glVertexAttribL3d", .{&bindings.vertexAttribL3d});
        load("glVertexAttribL4d", .{&bindings.vertexAttribL4d});
        load("glVertexAttribL1dv", .{&bindings.vertexAttribL1dv});
        load("glVertexAttribL2dv", .{&bindings.vertexAttribL2dv});
        load("glVertexAttribL3dv", .{&bindings.vertexAttribL3dv});
        load("glVertexAttribL4dv", .{&bindings.vertexAttribL4dv});
        load("glViewportArrayv", .{&bindings.viewportArrayv});
        load("glViewportIndexedf", .{&bindings.viewportIndexedf});
        load("glViewportIndexedfv", .{&bindings.viewportIndexedfv});
        load("glScissorArrayv", .{&bindings.scissorArrayv});
        load("glScissorIndexed", .{&bindings.scissorIndexed});
        load("glScissorIndexedv", .{&bindings.scissorIndexedv});
        load("glDepthRangeArrayv", .{&bindings.depthRangeArrayv});
        load("glDepthRangeIndexed", .{&bindings.depthRangeIndexed});
        load("glGetFloati_v", .{&bindings.getFloati_v});
        load("glGetDoublei_v", .{&bindings.getDoublei_v});
    }

    // OpenGL 4.2
    if (ver >= 42) {
        load("glDrawArraysInstancedBaseInstance", .{&bindings.drawArraysInstancedBaseInstance});
        load("glDrawElementsInstancedBaseInstance", .{&bindings.drawElementsInstancedBaseInstance});
        load("glDrawElementsInstancedBaseVertexBaseInstance", .{&bindings.drawElementsInstancedBaseVertexBaseInstance});
        load("glGetInternalformativ", .{&bindings.getInternalformativ});
        load("glGetActiveAtomicCounterBufferiv", .{&bindings.getActiveAtomicCounterBufferiv});
        load("glBindImageTexture", .{&bindings.bindImageTexture});
        load("glMemoryBarrier", .{&bindings.memoryBarrier});
        load("glTexStorage1D", .{&bindings.texStorage1D});
        load("glTexStorage2D", .{&bindings.texStorage2D});
        load("glTexStorage3D", .{&bindings.texStorage3D});
        load("glDrawTransformFeedbackInstanced", .{&bindings.drawTransformFeedbackInstanced});
        load("glDrawTransformFeedbackStreamInstanced", .{&bindings.drawTransformFeedbackStreamInstanced});
    }

    // OpenGL 4.3
    if (ver >= 43) {
        load("glClearBufferData", .{&bindings.clearBufferData});
        load("glClearBufferSubData", .{&bindings.clearBufferSubData});
        load("glDispatchCompute", .{&bindings.dispatchCompute});
        load("glDispatchComputeIndirect", .{&bindings.dispatchComputeIndirect});
        load("glCopyImageSubData", .{&bindings.copyImageSubData});
        load("glFramebufferParameteri", .{&bindings.framebufferParameteri});
        load("glGetFramebufferParameteriv", .{&bindings.getFramebufferParameteriv});
        load("glGetInternalformati64v", .{&bindings.getInternalformati64v});
        load("glInvalidateTexSubImage", .{&bindings.invalidateTexSubImage});
        load("glInvalidateTexImage", .{&bindings.invalidateTexImage});
        load("glInvalidateBufferSubData", .{&bindings.invalidateBufferSubData});
        load("glInvalidateBufferData", .{&bindings.invalidateBufferData});
        load("glInvalidateFramebuffer", .{&bindings.invalidateFramebuffer});
        load("glInvalidateSubFramebuffer", .{&bindings.invalidateSubFramebuffer});
        load("glMultiDrawArraysIndirect", .{&bindings.multiDrawArraysIndirect});
        load("glMultiDrawElementsIndirect", .{&bindings.multiDrawElementsIndirect});
        load("glGetProgramInterfaceiv", .{&bindings.getProgramInterfaceiv});
        load("glGetProgramResourceIndex", .{&bindings.getProgramResourceIndex});
        load("glGetProgramResourceName", .{&bindings.getProgramResourceName});
        load("glGetProgramResourceiv", .{&bindings.getProgramResourceiv});
        load("glGetProgramResourceLocation", .{&bindings.getProgramResourceLocation});
        load("glGetProgramResourceLocationIndex", .{&bindings.getProgramResourceLocationIndex});
        load("glShaderStorageBlockBinding", .{&bindings.shaderStorageBlockBinding});
        load("glTexBufferRange", .{&bindings.texBufferRange});
        load("glTexStorage2DMultisample", .{&bindings.texStorage2DMultisample});
        load("glTexStorage3DMultisample", .{&bindings.texStorage3DMultisample});
        load("glTextureView", .{&bindings.textureView});
        load("glBindVertexBuffer", .{&bindings.bindVertexBuffer});
        load("glVertexAttribFormat", .{&bindings.vertexAttribFormat});
        load("glVertexAttribIFormat", .{&bindings.vertexAttribIFormat});
        load("glVertexAttribLFormat", .{&bindings.vertexAttribLFormat});
        load("glVertexAttribBinding", .{&bindings.vertexAttribBinding});
        load("glVertexBindingDivisor", .{&bindings.vertexBindingDivisor});
        load("glDebugMessageControl", .{&bindings.debugMessageControl});
        load("glDebugMessageInsert", .{&bindings.debugMessageInsert});
        load("glDebugMessageCallback", .{&bindings.debugMessageCallback});
        load("glGetDebugMessageLog", .{&bindings.getDebugMessageLog});
        load("glPushDebugGroup", .{&bindings.pushDebugGroup});
        load("glPopDebugGroup", .{&bindings.popDebugGroup});
        load("glObjectLabel", .{&bindings.objectLabel});
        load("glGetObjectLabel", .{&bindings.getObjectLabel});
        load("glObjectPtrLabel", .{&bindings.objectPtrLabel});
        load("glGetObjectPtrLabel", .{&bindings.getObjectPtrLabel});
        load("glGetPointerv", .{&bindings.getPointerv});
    }

    // OpenGL 4.4
    if (ver >= 44) {
        load("glBufferStorage", .{&bindings.bufferStorage});
        load("glClearTexImage", .{&bindings.clearTexImage});
        load("glClearTexSubImage", .{&bindings.clearTexSubImage});
        load("glBindBuffersBase", .{&bindings.bindBuffersBase});
        load("glBindBuffersRange", .{&bindings.bindBuffersRange});
        load("glBindTextures", .{&bindings.bindTextures});
        load("glBindSamplers", .{&bindings.bindSamplers});
        load("glBindImageTextures", .{&bindings.bindImageTextures});
        load("glBindVertexBuffers", .{&bindings.bindVertexBuffers});
    }

    // OpenGL 4.5
    if (ver >= 45) {
        load("glClipControl", .{&bindings.clipControl});
        load("glCreateTransformFeedbacks", .{&bindings.createTransformFeedbacks});
        load("glTransformFeedbackBufferBase", .{&bindings.transformFeedbackBufferBase});
        load("glTransformFeedbackBufferRange", .{&bindings.transformFeedbackBufferRange});
        load("glGetTransformFeedbackiv", .{&bindings.getTransformFeedbackiv});
        load("glGetTransformFeedbacki_v", .{&bindings.getTransformFeedbacki_v});
        load("glGetTransformFeedbacki64_v", .{&bindings.getTransformFeedbacki64_v});
        load("glCreateBuffers", .{&bindings.createBuffers});
        load("glNamedBufferStorage", .{&bindings.namedBufferStorage});
        load("glNamedBufferData", .{&bindings.namedBufferData});
        load("glNamedBufferSubData", .{&bindings.namedBufferSubData});
        load("glCopyNamedBufferSubData", .{&bindings.copyNamedBufferSubData});
        load("glClearNamedBufferData", .{&bindings.clearNamedBufferData});
        load("glClearNamedBufferSubData", .{&bindings.clearNamedBufferSubData});
        load("glMapNamedBuffer", .{&bindings.mapNamedBuffer});
        load("glMapNamedBufferRange", .{&bindings.mapNamedBufferRange});
        load("glUnmapNamedBuffer", .{&bindings.unmapNamedBuffer});
        load("glFlushMappedNamedBufferRange", .{&bindings.flushMappedNamedBufferRange});
        load("glGetNamedBufferParameteriv", .{&bindings.getNamedBufferParameteriv});
        load("glGetNamedBufferParameteri64v", .{&bindings.getNamedBufferParameteri64v});
        load("glGetNamedBufferPointerv", .{&bindings.getNamedBufferPointerv});
        load("glGetNamedBufferSubData", .{&bindings.getNamedBufferSubData});
        load("glCreateFramebuffers", .{&bindings.createFramebuffers});
        load("glNamedFramebufferRenderbuffer", .{&bindings.namedFramebufferRenderbuffer});
        load("glNamedFramebufferParameteri", .{&bindings.namedFramebufferParameteri});
        load("glNamedFramebufferTexture", .{&bindings.namedFramebufferTexture});
        load("glNamedFramebufferTextureLayer", .{&bindings.namedFramebufferTextureLayer});
        load("glNamedFramebufferDrawBuffer", .{&bindings.namedFramebufferDrawBuffer});
        load("glNamedFramebufferDrawBuffers", .{&bindings.namedFramebufferDrawBuffers});
        load("glNamedFramebufferReadBuffer", .{&bindings.namedFramebufferReadBuffer});
        load("glInvalidateNamedFramebufferData", .{&bindings.invalidateNamedFramebufferData});
        load("glInvalidateNamedFramebufferSubData", .{&bindings.invalidateNamedFramebufferSubData});
        load("glClearNamedFramebufferiv", .{&bindings.clearNamedFramebufferiv});
        load("glClearNamedFramebufferuiv", .{&bindings.clearNamedFramebufferuiv});
        load("glClearNamedFramebufferfv", .{&bindings.clearNamedFramebufferfv});
        load("glClearNamedFramebufferfi", .{&bindings.clearNamedFramebufferfi});
        load("glBlitNamedFramebuffer", .{&bindings.blitNamedFramebuffer});
        load("glCheckNamedFramebufferStatus", .{&bindings.checkNamedFramebufferStatus});
        load("glGetNamedFramebufferParameteriv", .{&bindings.getNamedFramebufferParameteriv});
        load("glGetNamedFramebufferAttachmentParameteriv", .{&bindings.getNamedFramebufferAttachmentParameteriv});
        load("glCreateRenderbuffers", .{&bindings.createRenderbuffers});
        load("glNamedRenderbufferStorage", .{&bindings.namedRenderbufferStorage});
        load("glNamedRenderbufferStorageMultisample", .{&bindings.namedRenderbufferStorageMultisample});
        load("glGetNamedRenderbufferParameteriv", .{&bindings.getNamedRenderbufferParameteriv});
        load("glCreateTextures", .{&bindings.createTextures});
        load("glTextureBuffer", .{&bindings.textureBuffer});
        load("glTextureBufferRange", .{&bindings.textureBufferRange});
        load("glTextureStorage1D", .{&bindings.textureStorage1D});
        load("glTextureStorage2D", .{&bindings.textureStorage2D});
        load("glTextureStorage3D", .{&bindings.textureStorage3D});
        load("glTextureStorage2DMultisample", .{&bindings.textureStorage2DMultisample});
        load("glTextureStorage3DMultisample", .{&bindings.textureStorage3DMultisample});
        load("glTextureSubImage1D", .{&bindings.textureSubImage1D});
        load("glTextureSubImage2D", .{&bindings.textureSubImage2D});
        load("glTextureSubImage3D", .{&bindings.textureSubImage3D});
        load("glCompressedTextureSubImage1D", .{&bindings.compressedTextureSubImage1D});
        load("glCompressedTextureSubImage2D", .{&bindings.compressedTextureSubImage2D});
        load("glCompressedTextureSubImage3D", .{&bindings.compressedTextureSubImage3D});
        load("glCopyTextureSubImage1D", .{&bindings.copyTextureSubImage1D});
        load("glCopyTextureSubImage2D", .{&bindings.copyTextureSubImage2D});
        load("glCopyTextureSubImage3D", .{&bindings.copyTextureSubImage3D});
        load("glTextureParameterf", .{&bindings.textureParameterf});
        load("glTextureParameterfv", .{&bindings.textureParameterfv});
        load("glTextureParameteri", .{&bindings.textureParameteri});
        load("glTextureParameterIiv", .{&bindings.textureParameterIiv});
        load("glTextureParameterIuiv", .{&bindings.textureParameterIuiv});
        load("glTextureParameteriv", .{&bindings.textureParameteriv});
        load("glGenerateTextureMipmap", .{&bindings.generateTextureMipmap});
        load("glBindTextureUnit", .{&bindings.bindTextureUnit});
        load("glGetTextureImage", .{&bindings.getTextureImage});
        load("glGetCompressedTextureImage", .{&bindings.getCompressedTextureImage});
        load("glGetTextureLevelParameterfv", .{&bindings.getTextureLevelParameterfv});
        load("glGetTextureLevelParameteriv", .{&bindings.getTextureLevelParameteriv});
        load("glGetTextureParameterfv", .{&bindings.getTextureParameterfv});
        load("glGetTextureParameterIiv", .{&bindings.getTextureParameterIiv});
        load("glGetTextureParameterIuiv", .{&bindings.getTextureParameterIuiv});
        load("glGetTextureParameteriv", .{&bindings.getTextureParameteriv});
        load("glCreateVertexArrays", .{&bindings.createVertexArrays});
        load("glDisableVertexArrayAttrib", .{&bindings.disableVertexArrayAttrib});
        load("glEnableVertexArrayAttrib", .{&bindings.enableVertexArrayAttrib});
        load("glVertexArrayElementBuffer", .{&bindings.vertexArrayElementBuffer});
        load("glVertexArrayVertexBuffer", .{&bindings.vertexArrayVertexBuffer});
        load("glVertexArrayVertexBuffers", .{&bindings.vertexArrayVertexBuffers});
        load("glVertexArrayAttribBinding", .{&bindings.vertexArrayAttribBinding});
        load("glVertexArrayAttribFormat", .{&bindings.vertexArrayAttribFormat});
        load("glVertexArrayAttribIFormat", .{&bindings.vertexArrayAttribIFormat});
        load("glVertexArrayAttribLFormat", .{&bindings.vertexArrayAttribLFormat});
        load("glVertexArrayBindingDivisor", .{&bindings.vertexArrayBindingDivisor});
        load("glGetVertexArrayiv", .{&bindings.getVertexArrayiv});
        load("glGetVertexArrayIndexediv", .{&bindings.getVertexArrayIndexediv});
        load("glGetVertexArrayIndexed64iv", .{&bindings.getVertexArrayIndexed64iv});
        load("glCreateSamplers", .{&bindings.createSamplers});
        load("glCreateProgramPipelines", .{&bindings.createProgramPipelines});
        load("glCreateQueries", .{&bindings.createQueries});
        load("glGetQueryBufferObjecti64v", .{&bindings.getQueryBufferObjecti64v});
        load("glGetQueryBufferObjectiv", .{&bindings.getQueryBufferObjectiv});
        load("glGetQueryBufferObjectui64v", .{&bindings.getQueryBufferObjectui64v});
        load("glGetQueryBufferObjectuiv", .{&bindings.getQueryBufferObjectuiv});
        load("glMemoryBarrierByRegion", .{&bindings.memoryBarrierByRegion});
        load("glGetTextureSubImage", .{&bindings.getTextureSubImage});
        load("glGetCompressedTextureSubImage", .{&bindings.getCompressedTextureSubImage});
        load("glGetGraphicsResetStatus", .{&bindings.getGraphicsResetStatus});
        load("glGetnCompressedTexImage", .{&bindings.getnCompressedTexImage});
        load("glGetnTexImage", .{&bindings.getnTexImage});
        load("glGetnUniformdv", .{&bindings.getnUniformdv});
        load("glGetnUniformfv", .{&bindings.getnUniformfv});
        load("glGetnUniformiv", .{&bindings.getnUniformiv});
        load("glGetnUniformuiv", .{&bindings.getnUniformuiv});
        load("glReadnPixels", .{&bindings.readnPixels});
        load("glTextureBarrier", .{&bindings.textureBarrier});
    }

    // OpenGL 4.6
    if (ver >= 46) {
        load("glMultiDrawArraysIndirectCount", .{&bindings.multiDrawArraysIndirectCount});
        load("glMultiDrawElementsIndirectCount", .{&bindings.multiDrawElementsIndirectCount});
        load("glPolygonOffsetClamp", .{&bindings.polygonOffsetClamp});
        load("glSpecializeShader", .{&bindings.specializeShader});
    }
}

/// DEPRECATED
/// Loads a subset of OpenGL 4.6 (Compatibility Profile) + some useful, multivendor (NVIDIA, AMD) extensions.
pub fn loadCompatProfileExt(loader: LoaderFn) void {
    try loadCoreProfile(loader, 4, 6);

    load("glBegin", .{&bindings.begin});
    load("glEnd", .{&bindings.end});
    load("glNewList", .{&bindings.newList});
    load("glCallList", .{&bindings.callList});
    load("glEndList", .{&bindings.endList});
    load("glLoadIdentity", .{&bindings.loadIdentity});
    load("glVertex2fv", .{&bindings.vertex2fv});
    load("glVertex3fv", .{&bindings.vertex3fv});
    load("glVertex4fv", .{&bindings.vertex4fv});
    load("glColor3fv", .{&bindings.color3fv});
    load("glColor4fv", .{&bindings.color4fv});
    load("glRectf", .{&bindings.rectf});
    load("glMatrixMode", .{&bindings.matrixMode});
    load("glVertex2f", .{&bindings.vertex2f});
    load("glVertex2d", .{&bindings.vertex2d});
    load("glVertex2i", .{&bindings.vertex2i});
    load("glColor3f", .{&bindings.color3f});
    load("glColor4f", .{&bindings.color4f});
    load("glColor4ub", .{&bindings.color4ub});
    load("glPushMatrix", .{&bindings.pushMatrix});
    load("glPopMatrix", .{&bindings.popMatrix});
    load("glRotatef", .{&bindings.rotatef});
    load("glScalef", .{&bindings.scalef});
    load("glTranslatef", .{&bindings.translatef});
    load("glMatrixLoadIdentityEXT", .{&bindings.matrixLoadIdentityEXT});
    load("glMatrixOrthoEXT", .{&bindings.matrixOrthoEXT});
    //load("glVertexP2ui", .{&bindings.vertexP2ui});
    //load("glVertexP2uiv", .{&bindings.vertexP2uiv});
    //load("glVertexP3ui", .{&bindings.vertexP3ui});
    //load("glVertexP3uiv", .{&bindings.vertexP3uiv});
    //load("glVertexP4ui", .{&bindings.vertexP4ui});
    //load("glVertexP4uiv", .{&bindings.vertexP4uiv});
    //load("glTexCoordP1ui", .{&bindings.texCoordP1ui});
    //load("glTexCoordP1uiv", .{&bindings.texCoordP1uiv});
    //load("glTexCoordP2ui", .{&bindings.texCoordP2ui});
    //load("glTexCoordP2uiv", .{&bindings.texCoordP2uiv});
    //load("glTexCoordP3ui", .{&bindings.texCoordP3ui});
    //load("glTexCoordP3uiv", .{&bindings.texCoordP3uiv});
    //load("glTexCoordP4ui", .{&bindings.texCoordP4ui});
    //load("glTexCoordP4uiv", .{&bindings.texCoordP4uiv});
    //load("glMultiTexCoordP1ui", .{&bindings.multiTexCoordP1ui});
    //load("glMultiTexCoordP1uiv", .{&bindings.multiTexCoordP1uiv});
    //load("glMultiTexCoordP2ui", .{&bindings.multiTexCoordP2ui});
    //load("glMultiTexCoordP2uiv", .{&bindings.multiTexCoordP2uiv});
    //load("glMultiTexCoordP3ui", .{&bindings.multiTexCoordP3ui});
    //load("glMultiTexCoordP3uiv", .{&bindings.multiTexCoordP3uiv});
    //load("glMultiTexCoordP4ui", .{&bindings.multiTexCoordP4ui});
    //load("glMultiTexCoordP4uiv", .{&bindings.multiTexCoordP4uiv});
    //load("glNormalP3ui", .{&bindings.normalP3ui});
    //load("glNormalP3uiv", .{&bindings.normalP3uiv});
    //load("glColorP3ui", .{&bindings.colorP3ui});
    //load("glColorP3uiv", .{&bindings.colorP3uiv});
    //load("glColorP4ui", .{&bindings.colorP4ui});
    //load("glColorP4uiv", .{&bindings.colorP4uiv});
    //load("glSecondaryColorP3ui", .{&bindings.secondaryColorP3ui});
    //load("glSecondaryColorP3uiv", .{&bindings.secondaryColorP3uiv});
}

pub fn loadEsProfile(loader: LoaderFn, major: u32, minor: u32) void {
    const ver = 10 * major + minor;

    assert(major >= 1 and major <= 3);
    assert(minor >= 0 and minor <= 2);
    assert(ver >= 10 and ver <= 32);

    loaderFunc = loader;

    // OpenGL ES 1.0
    if (ver >= 10) {
        load("glCullFace", .{&bindings.cullFace});
        load("glFrontFace", .{&bindings.frontFace});
        load("glHint", .{&bindings.hint});
        load("glLineWidth", .{&bindings.lineWidth});
        load("glScissor", .{&bindings.scissor});
        load("glTexParameterf", .{&bindings.texParameterf});
        load("glTexParameterfv", .{&bindings.texParameterfv});
        load("glTexParameteri", .{&bindings.texParameteri});
        load("glTexParameteriv", .{&bindings.texParameteriv});
        load("glTexImage2D", .{&bindings.texImage2D});
        load("glClear", .{&bindings.clear});
        load("glClearColor", .{&bindings.clearColor});
        load("glClearStencil", .{&bindings.clearStencil});
        load("glClearDepthf", .{&bindings.clearDepthf});
        load("glStencilMask", .{&bindings.stencilMask});
        load("glColorMask", .{&bindings.colorMask});
        load("glDepthMask", .{&bindings.depthMask});
        load("glDisable", .{&bindings.disable});
        load("glEnable", .{&bindings.enable});
        load("glFinish", .{&bindings.finish});
        load("glFlush", .{&bindings.flush});
        load("glBlendFunc", .{&bindings.blendFunc});
        load("glStencilFunc", .{&bindings.stencilFunc});
        load("glStencilOp", .{&bindings.stencilOp});
        load("glDepthFunc", .{&bindings.depthFunc});
        load("glPixelStorei", .{&bindings.pixelStorei});
        load("glReadPixels", .{&bindings.readPixels});
        load("glGetBooleanv", .{&bindings.getBooleanv});
        load("glGetError", .{&bindings.getError});
        load("glGetFloatv", .{&bindings.getFloatv});
        load("glGetIntegerv", .{&bindings.getIntegerv});
        load("glGetString", .{&bindings.getString});
        load("glIsEnabled", .{&bindings.isEnabled});
        load("glDepthRangef", .{&bindings.depthRangef});
        load("glViewport", .{&bindings.viewport});
        load("glDrawArrays", .{&bindings.drawArrays});
        load("glDrawElements", .{&bindings.drawElements});
        load("glPolygonOffset", .{&bindings.polygonOffset});
        load("glCopyTexImage2D", .{&bindings.copyTexImage2D});
        load("glCopyTexSubImage2D", .{&bindings.copyTexSubImage2D});
        load("glTexSubImage2D", .{&bindings.texSubImage2D});
        load("glBindTexture", .{&bindings.bindTexture});
        load("glDeleteTextures", .{&bindings.deleteTextures});
        load("glGenTextures", .{&bindings.genTextures});
        load("glIsTexture", .{&bindings.isTexture});
        load("glActiveTexture", .{&bindings.activeTexture});
        load("glSampleCoverage", .{&bindings.sampleCoverage});
        load("glCompressedTexImage2D", .{&bindings.compressedTexImage2D});
        load("glCompressedTexSubImage2D", .{&bindings.compressedTexSubImage2D});
    }

    // OpenGL ES 1.1
    if (ver >= 11) {
        load("glBlendFuncSeparate", .{&bindings.blendFuncSeparate});
        load("glBlendColor", .{&bindings.blendColor});
        load("glBlendEquation", .{&bindings.blendEquation});
        load("glBindBuffer", .{&bindings.bindBuffer});
        load("glDeleteBuffers", .{&bindings.deleteBuffers});
        load("glGenBuffers", .{&bindings.genBuffers});
        load("glIsBuffer", .{&bindings.isBuffer});
        load("glBufferData", .{&bindings.bufferData});
        load("glBufferSubData", .{&bindings.bufferSubData});
        load("glGetBufferParameteriv", .{&bindings.getBufferParameteriv});
    }

    // OpenGL ES 2.0
    if (ver >= 20) {
        load("glBlendEquationSeparate", .{&bindings.blendEquationSeparate});
        load("glStencilOpSeparate", .{&bindings.stencilOpSeparate});
        load("glStencilFuncSeparate", .{&bindings.stencilFuncSeparate});
        load("glStencilMaskSeparate", .{&bindings.stencilMaskSeparate});
        load("glAttachShader", .{&bindings.attachShader});
        load("glBindAttribLocation", .{&bindings.bindAttribLocation});
        load("glCompileShader", .{&bindings.compileShader});
        load("glCreateProgram", .{&bindings.createProgram});
        load("glCreateShader", .{&bindings.createShader});
        load("glDeleteProgram", .{&bindings.deleteProgram});
        load("glDeleteShader", .{&bindings.deleteShader});
        load("glDetachShader", .{&bindings.detachShader});
        load("glDisableVertexAttribArray", .{&bindings.disableVertexAttribArray});
        load("glEnableVertexAttribArray", .{&bindings.enableVertexAttribArray});
        load("glGetActiveAttrib", .{&bindings.getActiveAttrib});
        load("glGetActiveUniform", .{&bindings.getActiveUniform});
        load("glGetAttachedShaders", .{&bindings.getAttachedShaders});
        load("glGetAttribLocation", .{&bindings.getAttribLocation});
        load("glGetProgramiv", .{&bindings.getProgramiv});
        load("glGetProgramInfoLog", .{&bindings.getProgramInfoLog});
        load("glGetShaderiv", .{&bindings.getShaderiv});
        load("glGetShaderInfoLog", .{&bindings.getShaderInfoLog});
        load("glGetShaderSource", .{&bindings.getShaderSource});
        load("glGetUniformLocation", .{&bindings.getUniformLocation});
        load("glGetUniformfv", .{&bindings.getUniformfv});
        load("glGetUniformiv", .{&bindings.getUniformiv});
        load("glGetVertexAttribPointerv", .{&bindings.getVertexAttribPointerv});
        load("glIsProgram", .{&bindings.isProgram});
        load("glIsShader", .{&bindings.isShader});
        load("glLinkProgram", .{&bindings.linkProgram});
        load("glShaderSource", .{&bindings.shaderSource});
        load("glUseProgram", .{&bindings.useProgram});
        load("glUniform1f", .{&bindings.uniform1f});
        load("glUniform2f", .{&bindings.uniform2f});
        load("glUniform3f", .{&bindings.uniform3f});
        load("glUniform4f", .{&bindings.uniform4f});
        load("glUniform1i", .{&bindings.uniform1i});
        load("glUniform2i", .{&bindings.uniform2i});
        load("glUniform3i", .{&bindings.uniform3i});
        load("glUniform4i", .{&bindings.uniform4i});
        load("glUniform1fv", .{&bindings.uniform1fv});
        load("glUniform2fv", .{&bindings.uniform2fv});
        load("glUniform3fv", .{&bindings.uniform3fv});
        load("glUniform4fv", .{&bindings.uniform4fv});
        load("glUniform1iv", .{&bindings.uniform1iv});
        load("glUniform2iv", .{&bindings.uniform2iv});
        load("glUniform3iv", .{&bindings.uniform3iv});
        load("glUniform4iv", .{&bindings.uniform4iv});
        load("glUniformMatrix2fv", .{&bindings.uniformMatrix2fv});
        load("glUniformMatrix3fv", .{&bindings.uniformMatrix3fv});
        load("glUniformMatrix4fv", .{&bindings.uniformMatrix4fv});
        load("glValidateProgram", .{&bindings.validateProgram});
        load("glVertexAttribPointer", .{&bindings.vertexAttribPointer});
        load("glIsRenderbuffer", .{&bindings.isRenderbuffer});
        load("glBindRenderbuffer", .{&bindings.bindRenderbuffer});
        load("glDeleteRenderbuffers", .{&bindings.deleteRenderbuffers});
        load("glGenRenderbuffers", .{&bindings.genRenderbuffers});
        load("glRenderbufferStorage", .{&bindings.renderbufferStorage});
        load("glGetRenderbufferParameteriv", .{&bindings.getRenderbufferParameteriv});
        load("glIsFramebuffer", .{&bindings.isFramebuffer});
        load("glBindFramebuffer", .{&bindings.bindFramebuffer});
        load("glDeleteFramebuffers", .{&bindings.deleteFramebuffers});
        load("glGenFramebuffers", .{&bindings.genFramebuffers});
        load("glCheckFramebufferStatus", .{&bindings.checkFramebufferStatus});
        load("glFramebufferTexture2D", .{&bindings.framebufferTexture2D});
        load("glFramebufferRenderbuffer", .{&bindings.framebufferRenderbuffer});
        load("glGetFramebufferAttachmentParameteriv", .{&bindings.getFramebufferAttachmentParameteriv});
        load("glGenerateMipmap", .{&bindings.generateMipmap});
    }

    // OpenGL ES 3.0
    if (ver >= 30) {
        load("glUniformMatrix2x3fv", .{&bindings.uniformMatrix2x3fv});
        load("glUniformMatrix3x2fv", .{&bindings.uniformMatrix3x2fv});
        load("glUniformMatrix2x4fv", .{&bindings.uniformMatrix2x4fv});
        load("glUniformMatrix4x2fv", .{&bindings.uniformMatrix4x2fv});
        load("glUniformMatrix3x4fv", .{&bindings.uniformMatrix3x4fv});
        load("glUniformMatrix4x3fv", .{&bindings.uniformMatrix4x3fv});
        load("glGetBooleani_v", .{&bindings.getBooleani_v});
        load("glGetIntegeri_v", .{&bindings.getIntegeri_v});
        load("glBeginTransformFeedback", .{&bindings.beginTransformFeedback});
        load("glEndTransformFeedback", .{&bindings.endTransformFeedback});
        load("glBindBufferRange", .{&bindings.bindBufferRange});
        load("glBindBufferBase", .{&bindings.bindBufferBase});
        load("glTransformFeedbackVaryings", .{&bindings.transformFeedbackVaryings});
        load("glGetTransformFeedbackVarying", .{&bindings.getTransformFeedbackVarying});
        load("glVertexAttribIPointer", .{&bindings.vertexAttribIPointer});
        load("glGetVertexAttribIiv", .{&bindings.getVertexAttribIiv});
        load("glGetVertexAttribIuiv", .{&bindings.getVertexAttribIuiv});
        load("glGetUniformuiv", .{&bindings.getUniformuiv});
        load("glGetFragDataLocation", .{&bindings.getFragDataLocation});
        load("glUniform1ui", .{&bindings.uniform1ui});
        load("glUniform2ui", .{&bindings.uniform2ui});
        load("glUniform3ui", .{&bindings.uniform3ui});
        load("glUniform4ui", .{&bindings.uniform4ui});
        load("glUniform1uiv", .{&bindings.uniform1uiv});
        load("glUniform2uiv", .{&bindings.uniform2uiv});
        load("glUniform3uiv", .{&bindings.uniform3uiv});
        load("glUniform4uiv", .{&bindings.uniform4uiv});
        load("glClearBufferiv", .{&bindings.clearBufferiv});
        load("glClearBufferuiv", .{&bindings.clearBufferuiv});
        load("glClearBufferfv", .{&bindings.clearBufferfv});
        load("glClearBufferfi", .{&bindings.clearBufferfi});
        load("glGetStringi", .{&bindings.getStringi});
        load("glBlitFramebuffer", .{&bindings.blitFramebuffer});
        load("glRenderbufferStorageMultisample", .{&bindings.renderbufferStorageMultisample});
        load("glFramebufferTextureLayer", .{&bindings.framebufferTextureLayer});
        load("glMapBufferRange", .{&bindings.mapBufferRange});
        load("glFlushMappedBufferRange", .{&bindings.flushMappedBufferRange});
        load("glBindVertexArray", .{&bindings.bindVertexArray});
        load("glDeleteVertexArrays", .{&bindings.deleteVertexArrays});
        load("glGenVertexArrays", .{&bindings.genVertexArrays});
        load("glIsVertexArray", .{&bindings.isVertexArray});
        load("glDrawArraysInstanced", .{&bindings.drawArraysInstanced});
        load("glDrawElementsInstanced", .{&bindings.drawElementsInstanced});
        load("glCopyBufferSubData", .{&bindings.copyBufferSubData});
        load("glGetUniformIndices", .{&bindings.getUniformIndices});
        load("glGetActiveUniformsiv", .{&bindings.getActiveUniformsiv});
        load("glGetUniformBlockIndex", .{&bindings.getUniformBlockIndex});
        load("glGetActiveUniformBlockiv", .{&bindings.getActiveUniformBlockiv});
        load("glGetActiveUniformBlockName", .{&bindings.getActiveUniformBlockName});
        load("glUniformBlockBinding", .{&bindings.uniformBlockBinding});
        load("glFenceSync", .{&bindings.fenceSync});
        load("glIsSync", .{&bindings.isSync});
        load("glDeleteSync", .{&bindings.deleteSync});
        load("glClientWaitSync", .{&bindings.clientWaitSync});
        load("glWaitSync", .{&bindings.waitSync});
        load("glGetInteger64v", .{&bindings.getInteger64v});
        load("glGetSynciv", .{&bindings.getSynciv});
        load("glGetInteger64i_v", .{&bindings.getInteger64i_v});
        load("glGetBufferParameteri64v", .{&bindings.getBufferParameteri64v});
        load("glGetMultisamplefv", .{&bindings.getMultisamplefv});
        load("glSampleMaski", .{&bindings.sampleMaski});
        load("glGenSamplers", .{&bindings.genSamplers});
        load("glDeleteSamplers", .{&bindings.deleteSamplers});
        load("glIsSampler", .{&bindings.isSampler});
        load("glBindSampler", .{&bindings.bindSampler});
        load("glSamplerParameteri", .{&bindings.samplerParameteri});
        load("glSamplerParameteriv", .{&bindings.samplerParameteriv});
        load("glSamplerParameterf", .{&bindings.samplerParameterf});
        load("glSamplerParameterfv", .{&bindings.samplerParameterfv});
        load("glSamplerParameterIiv", .{&bindings.samplerParameterIiv});
        load("glSamplerParameterIuiv", .{&bindings.samplerParameterIuiv});
        load("glGetSamplerParameteriv", .{&bindings.getSamplerParameteriv});
        load("glGetSamplerParameterIiv", .{&bindings.getSamplerParameterIiv});
        load("glGetSamplerParameterfv", .{&bindings.getSamplerParameterfv});
        load("glVertexAttribDivisor", .{&bindings.vertexAttribDivisor});
    }
}

pub fn loadExtension(loader: LoaderFn, extension: Extension) void {
    loaderFunc = loader;

    switch (extension) {
        // KHR extensions ////////////////////////////////////////////////////////////////////////////////////
        .KHR_debug => {
            load("glDebugMessageControl", .{&bindings.debugMessageControl});
            load("glDebugMessageInsert", .{&bindings.debugMessageInsert});
            load("glDebugMessageCallback", .{&bindings.debugMessageCallback});
            load("glGetDebugMessageLog", .{&bindings.getDebugMessageLog});
            load("glGetPointerv", .{&bindings.getPointerv});
            load("glPushDebugGroup", .{&bindings.pushDebugGroup});
            load("glPopDebugGroup", .{&bindings.popDebugGroup});
            load("glObjectLabel", .{&bindings.objectLabel});
            load("glGetObjectLabel", .{&bindings.getObjectLabel});
            load("glObjectPtrLabel", .{&bindings.objectPtrLabel});
            load("glGetObjectPtrLabel", .{&bindings.getObjectPtrLabel});
        },
        // EXT extensions ////////////////////////////////////////////////////////////////////////////////////
        .EXT_copy_texture => {
            load("glCopyTexImage1DEXT", .{ &bindings.copyTexImage1DEXT, &bindings.copyTexImage1D });
            load("glCopyTexImage2DEXT", .{ &bindings.copyTexImage2DEXT, &bindings.copyTexImage2D });
            load("glCopyTexSubImage1DEXT", .{ &bindings.copyTexSubImage1DEXT, &bindings.copyTexSubImage1D });
            load("glCopyTexSubImage2DEXT", .{ &bindings.copyTexSubImage2DEXT, &bindings.copyTexSubImage2D });
            load("glCopyTexSubImage3DEXT", .{ &bindings.copyTexSubImage3DEXT, &bindings.copyTexSubImage3D });
        },
        // NV extensions /////////////////////////////////////////////////////////////////////////////////////
        .NV_bindless_texture => {
            load("glGetTextureHandleNV", .{&bindings.getTextureHandleNV});
            load("glMakeTextureHandleResidentNV", .{&bindings.makeTextureHandleResidentNV});
            load("glProgramUniformHandleui64NV", .{&bindings.programUniformHandleui64NV});
        },
        .NV_shader_buffer_load => {
            load("glMakeNamedBufferResidentNV", .{&bindings.makeNamedBufferResidentNV});
            load("glGetNamedBufferParameterui64vNV", .{&bindings.getNamedBufferParameterui64vNV});
            load("glProgramUniformui64vNV", .{&bindings.programUniformui64NV});
        },
    }
}

pub fn loadEsExtension(loader: LoaderFn, extension: EsExtension) void {
    loaderFunc = loader;

    switch (extension) {
        // KHR ES extensions /////////////////////////////////////////////////////////////////////////////////
        .KHR_debug => {
            load("glDebugMessageControlKHR", .{ &bindings.debugMessageControl, &bindings.debugMessageControlKHR });
            load("glDebugMessageInsertKHR", .{ &bindings.debugMessageInsert, &bindings.debugMessageInsertKHR });
            load("glDebugMessageCallbackKHR", .{ &bindings.debugMessageCallback, &bindings.debugMessageCallbackKHR });
            load("glGetDebugMessageLogKHR", .{ &bindings.getDebugMessageLog, &bindings.getDebugMessageLogKHR });
            load("glGetPointervKHR", .{ &bindings.getPointerv, &bindings.getPointervKHR });
            load("glPushDebugGroupKHR", .{ &bindings.pushDebugGroup, &bindings.pushDebugGroupKHR });
            load("glPopDebugGroupKHR", .{ &bindings.popDebugGroup, &bindings.popDebugGroupKHR });
            load("glObjectLabelKHR", .{ &bindings.objectLabel, &bindings.objectLabelKHR });
            load("glGetObjectLabelKHR", .{ &bindings.getObjectLabel, &bindings.getObjectLabelKHR });
            load("glObjectPtrLabelKHR", .{ &bindings.objectPtrLabel, &bindings.objectPtrLabelKHR });
            load("glGetObjectPtrLabelKHR", .{ &bindings.getObjectPtrLabel, &bindings.getObjectPtrLabelKHR });
        },
        // OES ES extensions /////////////////////////////////////////////////////////////////////////////////
        .OES_vertex_array_object => {
            load("glBindVertexArrayOES", .{ &bindings.bindVertexArray, &bindings.bindVertexArrayOES });
            load("glDeleteVertexArraysOES", .{ &bindings.deleteVertexArrays, &bindings.deleteVertexArraysOES });
            load("glGenVertexArraysOES", .{ &bindings.genVertexArrays, &bindings.genVertexArraysOES });
            load("glIsVertexArrayOES", .{ &bindings.isVertexArray, &bindings.isVertexArrayOES });
        },
    }
}

pub fn loadWebProfile(loader: LoaderFn, webgl2: bool) void {
    loaderFunc = loader;

    // OpenGL ES 1.0
    load("glCullFace", .{&bindings.cullFace});
    load("glFrontFace", .{&bindings.frontFace});
    load("glHint", .{&bindings.hint});
    load("glLineWidth", .{&bindings.lineWidth});
    load("glScissor", .{&bindings.scissor});
    load("glTexParameterf", .{&bindings.texParameterf});
    load("glTexParameterfv", .{&bindings.texParameterfv});
    load("glTexParameteri", .{&bindings.texParameteri});
    load("glTexParameteriv", .{&bindings.texParameteriv});
    load("glTexImage2D", .{&bindings.texImage2D});
    load("glClear", .{&bindings.clear});
    load("glClearColor", .{&bindings.clearColor});
    load("glClearStencil", .{&bindings.clearStencil});
    load("glClearDepthf", .{&bindings.clearDepthf});
    load("glStencilMask", .{&bindings.stencilMask});
    load("glColorMask", .{&bindings.colorMask});
    load("glDepthMask", .{&bindings.depthMask});
    load("glDisable", .{&bindings.disable});
    load("glEnable", .{&bindings.enable});
    load("glFinish", .{&bindings.finish});
    load("glFlush", .{&bindings.flush});
    load("glBlendFunc", .{&bindings.blendFunc});
    load("glStencilFunc", .{&bindings.stencilFunc});
    load("glStencilOp", .{&bindings.stencilOp});
    load("glDepthFunc", .{&bindings.depthFunc});
    load("glPixelStorei", .{&bindings.pixelStorei});
    load("glReadPixels", .{&bindings.readPixels});
    load("glGetBooleanv", .{&bindings.getBooleanv});
    load("glGetError", .{&bindings.getError});
    load("glGetFloatv", .{&bindings.getFloatv});
    load("glGetIntegerv", .{&bindings.getIntegerv});
    load("glGetString", .{&bindings.getString});
    load("glIsEnabled", .{&bindings.isEnabled});
    load("glDepthRangef", .{&bindings.depthRangef});
    load("glViewport", .{&bindings.viewport});
    load("glDrawArrays", .{&bindings.drawArrays});
    load("glDrawElements", .{&bindings.drawElements});
    load("glPolygonOffset", .{&bindings.polygonOffset});
    load("glCopyTexImage2D", .{&bindings.copyTexImage2D});
    load("glCopyTexSubImage2D", .{&bindings.copyTexSubImage2D});
    load("glTexSubImage2D", .{&bindings.texSubImage2D});
    load("glBindTexture", .{&bindings.bindTexture});
    load("glDeleteTextures", .{&bindings.deleteTextures});
    load("glGenTextures", .{&bindings.genTextures});
    load("glIsTexture", .{&bindings.isTexture});
    load("glActiveTexture", .{&bindings.activeTexture});
    load("glSampleCoverage", .{&bindings.sampleCoverage});
    load("glCompressedTexImage2D", .{&bindings.compressedTexImage2D});
    load("glCompressedTexSubImage2D", .{&bindings.compressedTexSubImage2D});

    // OpenGL ES 1.1
    load("glBlendFuncSeparate", .{&bindings.blendFuncSeparate});
    load("glBlendColor", .{&bindings.blendColor});
    load("glBlendEquation", .{&bindings.blendEquation});
    load("glBindBuffer", .{&bindings.bindBuffer});
    load("glDeleteBuffers", .{&bindings.deleteBuffers});
    load("glGenBuffers", .{&bindings.genBuffers});
    load("glIsBuffer", .{&bindings.isBuffer});
    load("glBufferData", .{&bindings.bufferData});
    load("glBufferSubData", .{&bindings.bufferSubData});
    load("glGetBufferParameteriv", .{&bindings.getBufferParameteriv});

    // OpenGL ES 2.0
    load("glBlendEquationSeparate", .{&bindings.blendEquationSeparate});
    load("glStencilOpSeparate", .{&bindings.stencilOpSeparate});
    load("glStencilFuncSeparate", .{&bindings.stencilFuncSeparate});
    load("glStencilMaskSeparate", .{&bindings.stencilMaskSeparate});
    load("glAttachShader", .{&bindings.attachShader});
    load("glBindAttribLocation", .{&bindings.bindAttribLocation});
    load("glCompileShader", .{&bindings.compileShader});
    load("glCreateProgram", .{&bindings.createProgram});
    load("glCreateShader", .{&bindings.createShader});
    load("glDeleteProgram", .{&bindings.deleteProgram});
    load("glDeleteShader", .{&bindings.deleteShader});
    load("glDetachShader", .{&bindings.detachShader});
    load("glDisableVertexAttribArray", .{&bindings.disableVertexAttribArray});
    load("glEnableVertexAttribArray", .{&bindings.enableVertexAttribArray});
    load("glGetActiveAttrib", .{&bindings.getActiveAttrib});
    load("glGetActiveUniform", .{&bindings.getActiveUniform});
    load("glGetAttachedShaders", .{&bindings.getAttachedShaders});
    load("glGetAttribLocation", .{&bindings.getAttribLocation});
    load("glGetProgramiv", .{&bindings.getProgramiv});
    load("glGetProgramInfoLog", .{&bindings.getProgramInfoLog});
    load("glGetShaderiv", .{&bindings.getShaderiv});
    load("glGetShaderInfoLog", .{&bindings.getShaderInfoLog});
    load("glGetShaderSource", .{&bindings.getShaderSource});
    load("glGetUniformLocation", .{&bindings.getUniformLocation});
    load("glGetUniformfv", .{&bindings.getUniformfv});
    load("glGetUniformiv", .{&bindings.getUniformiv});
    load("glGetVertexAttribPointerv", .{&bindings.getVertexAttribPointerv});
    load("glIsProgram", .{&bindings.isProgram});
    load("glIsShader", .{&bindings.isShader});
    load("glLinkProgram", .{&bindings.linkProgram});
    load("glShaderSource", .{&bindings.shaderSource});
    load("glUseProgram", .{&bindings.useProgram});
    load("glUniform1f", .{&bindings.uniform1f});
    load("glUniform2f", .{&bindings.uniform2f});
    load("glUniform3f", .{&bindings.uniform3f});
    load("glUniform4f", .{&bindings.uniform4f});
    load("glUniform1i", .{&bindings.uniform1i});
    load("glUniform2i", .{&bindings.uniform2i});
    load("glUniform3i", .{&bindings.uniform3i});
    load("glUniform4i", .{&bindings.uniform4i});
    load("glUniform1fv", .{&bindings.uniform1fv});
    load("glUniform2fv", .{&bindings.uniform2fv});
    load("glUniform3fv", .{&bindings.uniform3fv});
    load("glUniform4fv", .{&bindings.uniform4fv});
    load("glUniform1iv", .{&bindings.uniform1iv});
    load("glUniform2iv", .{&bindings.uniform2iv});
    load("glUniform3iv", .{&bindings.uniform3iv});
    load("glUniform4iv", .{&bindings.uniform4iv});
    load("glUniformMatrix2fv", .{&bindings.uniformMatrix2fv});
    load("glUniformMatrix3fv", .{&bindings.uniformMatrix3fv});
    load("glUniformMatrix4fv", .{&bindings.uniformMatrix4fv});
    load("glValidateProgram", .{&bindings.validateProgram});
    load("glVertexAttribPointer", .{&bindings.vertexAttribPointer});
    load("glIsRenderbuffer", .{&bindings.isRenderbuffer});
    load("glBindRenderbuffer", .{&bindings.bindRenderbuffer});
    load("glDeleteRenderbuffers", .{&bindings.deleteRenderbuffers});
    load("glGenRenderbuffers", .{&bindings.genRenderbuffers});
    load("glRenderbufferStorage", .{&bindings.renderbufferStorage});
    load("glGetRenderbufferParameteriv", .{&bindings.getRenderbufferParameteriv});
    load("glIsFramebuffer", .{&bindings.isFramebuffer});
    load("glBindFramebuffer", .{&bindings.bindFramebuffer});
    load("glDeleteFramebuffers", .{&bindings.deleteFramebuffers});
    load("glGenFramebuffers", .{&bindings.genFramebuffers});
    load("glCheckFramebufferStatus", .{&bindings.checkFramebufferStatus});
    load("glFramebufferTexture2D", .{&bindings.framebufferTexture2D});
    load("glFramebufferRenderbuffer", .{&bindings.framebufferRenderbuffer});
    load("glGetFramebufferAttachmentParameteriv", .{&bindings.getFramebufferAttachmentParameteriv});
    load("glGenerateMipmap", .{&bindings.generateMipmap});

    if (webgl2) {
        // OpenGL ES 3.0
        load("glUniformMatrix2x3fv", .{&bindings.uniformMatrix2x3fv});
        load("glUniformMatrix3x2fv", .{&bindings.uniformMatrix3x2fv});
        load("glUniformMatrix2x4fv", .{&bindings.uniformMatrix2x4fv});
        load("glUniformMatrix4x2fv", .{&bindings.uniformMatrix4x2fv});
        load("glUniformMatrix3x4fv", .{&bindings.uniformMatrix3x4fv});
        load("glUniformMatrix4x3fv", .{&bindings.uniformMatrix4x3fv});
        load("glGetIntegeri_v", .{&bindings.getIntegeri_v});
        load("glBeginTransformFeedback", .{&bindings.beginTransformFeedback});
        load("glEndTransformFeedback", .{&bindings.endTransformFeedback});
        load("glBindBufferRange", .{&bindings.bindBufferRange});
        load("glBindBufferBase", .{&bindings.bindBufferBase});
        load("glTransformFeedbackVaryings", .{&bindings.transformFeedbackVaryings});
        load("glGetTransformFeedbackVarying", .{&bindings.getTransformFeedbackVarying});
        load("glVertexAttribIPointer", .{&bindings.vertexAttribIPointer});
        load("glGetVertexAttribIiv", .{&bindings.getVertexAttribIiv});
        load("glGetVertexAttribIuiv", .{&bindings.getVertexAttribIuiv});
        load("glGetUniformuiv", .{&bindings.getUniformuiv});
        load("glGetFragDataLocation", .{&bindings.getFragDataLocation});
        load("glUniform1ui", .{&bindings.uniform1ui});
        load("glUniform2ui", .{&bindings.uniform2ui});
        load("glUniform3ui", .{&bindings.uniform3ui});
        load("glUniform4ui", .{&bindings.uniform4ui});
        load("glUniform1uiv", .{&bindings.uniform1uiv});
        load("glUniform2uiv", .{&bindings.uniform2uiv});
        load("glUniform3uiv", .{&bindings.uniform3uiv});
        load("glUniform4uiv", .{&bindings.uniform4uiv});
        load("glClearBufferiv", .{&bindings.clearBufferiv});
        load("glClearBufferuiv", .{&bindings.clearBufferuiv});
        load("glClearBufferfv", .{&bindings.clearBufferfv});
        load("glClearBufferfi", .{&bindings.clearBufferfi});
        load("glGetStringi", .{&bindings.getStringi});
        load("glBlitFramebuffer", .{&bindings.blitFramebuffer});
        load("glRenderbufferStorageMultisample", .{&bindings.renderbufferStorageMultisample});
        load("glFramebufferTextureLayer", .{&bindings.framebufferTextureLayer});
        load("glBindVertexArray", .{&bindings.bindVertexArray});
        load("glDeleteVertexArrays", .{&bindings.deleteVertexArrays});
        load("glGenVertexArrays", .{&bindings.genVertexArrays});
        load("glIsVertexArray", .{&bindings.isVertexArray});
        load("glDrawArraysInstanced", .{&bindings.drawArraysInstanced});
        load("glDrawElementsInstanced", .{&bindings.drawElementsInstanced});
        load("glCopyBufferSubData", .{&bindings.copyBufferSubData});
        load("glGetUniformIndices", .{&bindings.getUniformIndices});
        load("glGetActiveUniformsiv", .{&bindings.getActiveUniformsiv});
        load("glGetUniformBlockIndex", .{&bindings.getUniformBlockIndex});
        load("glGetActiveUniformBlockiv", .{&bindings.getActiveUniformBlockiv});
        load("glGetActiveUniformBlockName", .{&bindings.getActiveUniformBlockName});
        load("glUniformBlockBinding", .{&bindings.uniformBlockBinding});
        load("glFenceSync", .{&bindings.fenceSync});
        load("glIsSync", .{&bindings.isSync});
        load("glDeleteSync", .{&bindings.deleteSync});
        load("glClientWaitSync", .{&bindings.clientWaitSync});
        load("glWaitSync", .{&bindings.waitSync});
        load("glGetInteger64v", .{&bindings.getInteger64v});
        load("glGetSynciv", .{&bindings.getSynciv});
        load("glGetInteger64i_v", .{&bindings.getInteger64i_v});
        load("glGetBufferParameteri64v", .{&bindings.getBufferParameteri64v});
        load("glGenSamplers", .{&bindings.genSamplers});
        load("glDeleteSamplers", .{&bindings.deleteSamplers});
        load("glIsSampler", .{&bindings.isSampler});
        load("glBindSampler", .{&bindings.bindSampler});
        load("glSamplerParameteri", .{&bindings.samplerParameteri});
        load("glSamplerParameteriv", .{&bindings.samplerParameteriv});
        load("glSamplerParameterf", .{&bindings.samplerParameterf});
        load("glSamplerParameterfv", .{&bindings.samplerParameterfv});
        load("glGetSamplerParameteriv", .{&bindings.getSamplerParameteriv});
        load("glGetSamplerParameterfv", .{&bindings.getSamplerParameterfv});
        load("glVertexAttribDivisor", .{&bindings.vertexAttribDivisor});
        load("glDrawBuffers", .{&bindings.drawBuffers});
    }
}

//--------------------------------------------------------------------------------------------------
fn load(proc_name: [:0]const u8, bind_addresses: anytype) void {
    const ProcType = @typeInfo(@TypeOf(bind_addresses.@"0")).pointer.child;
    const proc = getProcAddress(ProcType, proc_name) catch {
        return; // silently skip missing functions
    };
    inline for (bind_addresses) |bind_addr| {
        if (@typeInfo(@TypeOf(bind_addr)).pointer.child != ProcType) {
            @compileError("proc bindings should all be the same type");
        }
        bind_addr.* = proc;
    }
}

var loaderFunc: LoaderFn = undefined;

fn getProcAddress(comptime T: type, proc_name: [:0]const u8) !T {
    if (loaderFunc(proc_name)) |addr| {
        return @as(T, @ptrFromInt(@intFromPtr(addr)));
    }
    std.log.debug("zopengl: {s} not found", .{proc_name});
    return error.OpenGL_FunctionNotFound;
}

//--------------------------------------------------------------------------------------------------
//
// C exports
//
//--------------------------------------------------------------------------------------------------
const linkage: @import("std").builtin.GlobalLinkage = .strong;
comptime {
    //----------------------------------------------------------------------------------------------
    // OpenGL 1.0 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.cullFace, .{ .name = "glCullFace", .linkage = linkage });
    @export(&bindings.frontFace, .{ .name = "glFrontFace", .linkage = linkage });
    @export(&bindings.hint, .{ .name = "glHint", .linkage = linkage });
    @export(&bindings.lineWidth, .{ .name = "glLineWidth", .linkage = linkage });
    @export(&bindings.pointSize, .{ .name = "glPointSize", .linkage = linkage });
    @export(&bindings.polygonMode, .{ .name = "glPolygonMode", .linkage = linkage });
    @export(&bindings.scissor, .{ .name = "glScissor", .linkage = linkage });
    @export(&bindings.texParameterf, .{ .name = "glTexParameterf", .linkage = linkage });
    @export(&bindings.texParameterfv, .{ .name = "glTexParameterfv", .linkage = linkage });
    @export(&bindings.texParameteri, .{ .name = "glTexParameteri", .linkage = linkage });
    @export(&bindings.texParameteriv, .{ .name = "glTexParameteriv", .linkage = linkage });
    @export(&bindings.texImage1D, .{ .name = "glTexImage1D", .linkage = linkage });
    @export(&bindings.texImage2D, .{ .name = "glTexImage2D", .linkage = linkage });
    @export(&bindings.drawBuffer, .{ .name = "glDrawBuffer", .linkage = linkage });
    @export(&bindings.clear, .{ .name = "glClear", .linkage = linkage });
    @export(&bindings.clearColor, .{ .name = "glClearColor", .linkage = linkage });
    @export(&bindings.clearStencil, .{ .name = "glClearStencil", .linkage = linkage });
    @export(&bindings.stencilMask, .{ .name = "glStencilMask", .linkage = linkage });
    @export(&bindings.colorMask, .{ .name = "glColorMask", .linkage = linkage });
    @export(&bindings.depthMask, .{ .name = "glDepthMask", .linkage = linkage });
    @export(&bindings.disable, .{ .name = "glDisable", .linkage = linkage });
    @export(&bindings.enable, .{ .name = "glEnable", .linkage = linkage });
    @export(&bindings.finish, .{ .name = "glFinish", .linkage = linkage });
    @export(&bindings.flush, .{ .name = "glFlush", .linkage = linkage });
    @export(&bindings.blendFunc, .{ .name = "glBlendFunc", .linkage = linkage });
    @export(&bindings.logicOp, .{ .name = "glLogicOp", .linkage = linkage });
    @export(&bindings.stencilFunc, .{ .name = "glStencilFunc", .linkage = linkage });
    @export(&bindings.stencilOp, .{ .name = "glStencilOp", .linkage = linkage });
    @export(&bindings.depthFunc, .{ .name = "glDepthFunc", .linkage = linkage });
    @export(&bindings.pixelStoref, .{ .name = "glPixelStoref", .linkage = linkage });
    @export(&bindings.pixelStorei, .{ .name = "glPixelStorei", .linkage = linkage });
    @export(&bindings.readBuffer, .{ .name = "glReadBuffer", .linkage = linkage });
    @export(&bindings.readPixels, .{ .name = "glReadPixels", .linkage = linkage });
    @export(&bindings.getBooleanv, .{ .name = "glGetBooleanv", .linkage = linkage });
    @export(&bindings.getDoublev, .{ .name = "glGetDoublev", .linkage = linkage });
    @export(&bindings.getError, .{ .name = "glGetError", .linkage = linkage });
    @export(&bindings.getFloatv, .{ .name = "glGetFloatv", .linkage = linkage });
    @export(&bindings.getIntegerv, .{ .name = "glGetIntegerv", .linkage = linkage });
    @export(&bindings.getString, .{ .name = "glGetString", .linkage = linkage });
    @export(&bindings.getTexImage, .{ .name = "glGetTexImage", .linkage = linkage });
    @export(&bindings.getTexParameterfv, .{ .name = "glGetTexParameterfv", .linkage = linkage });
    @export(&bindings.getTexParameteriv, .{ .name = "glGetTexParameteriv", .linkage = linkage });
    @export(&bindings.getTexLevelParameterfv, .{ .name = "glGetTexLevelParameterfv", .linkage = linkage });
    @export(&bindings.getTexLevelParameteriv, .{ .name = "glGetTexLevelParameteriv", .linkage = linkage });
    @export(&bindings.isEnabled, .{ .name = "glIsEnabled", .linkage = linkage });
    @export(&bindings.depthRange, .{ .name = "glDepthRange", .linkage = linkage });
    @export(&bindings.viewport, .{ .name = "glViewport", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 1.1 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.drawArrays, .{ .name = "glDrawArrays", .linkage = linkage });
    @export(&bindings.drawElements, .{ .name = "glDrawElements", .linkage = linkage });
    @export(&bindings.polygonOffset, .{ .name = "glPolygonOffset", .linkage = linkage });
    @export(&bindings.copyTexImage1D, .{ .name = "glCopyTexImage1D", .linkage = linkage });
    @export(&bindings.copyTexImage2D, .{ .name = "glCopyTexImage2D", .linkage = linkage });
    @export(&bindings.copyTexSubImage1D, .{ .name = "glCopyTexSubImage1D", .linkage = linkage });
    @export(&bindings.copyTexSubImage2D, .{ .name = "glCopyTexSubImage2D", .linkage = linkage });
    @export(&bindings.texSubImage1D, .{ .name = "glTexSubImage1D", .linkage = linkage });
    @export(&bindings.texSubImage2D, .{ .name = "glTexSubImage2D", .linkage = linkage });
    @export(&bindings.bindTexture, .{ .name = "glBindTexture", .linkage = linkage });
    @export(&bindings.deleteTextures, .{ .name = "glDeleteTextures", .linkage = linkage });
    @export(&bindings.genTextures, .{ .name = "glGenTextures", .linkage = linkage });
    @export(&bindings.isTexture, .{ .name = "glIsTexture", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 1.2 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.drawRangeElements, .{ .name = "glDrawRangeElements", .linkage = linkage });
    @export(&bindings.texImage3D, .{ .name = "glTexImage3D", .linkage = linkage });
    @export(&bindings.texSubImage3D, .{ .name = "glTexSubImage3D", .linkage = linkage });
    @export(&bindings.copyTexSubImage3D, .{ .name = "glCopyTexSubImage3D", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 1.3 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.activeTexture, .{ .name = "glActiveTexture", .linkage = linkage });
    @export(&bindings.sampleCoverage, .{ .name = "glSampleCoverage", .linkage = linkage });
    @export(&bindings.compressedTexImage3D, .{ .name = "glCompressedTexImage3D", .linkage = linkage });
    @export(&bindings.compressedTexImage2D, .{ .name = "glCompressedTexImage2D", .linkage = linkage });
    @export(&bindings.compressedTexImage1D, .{ .name = "glCompressedTexImage1D", .linkage = linkage });
    @export(&bindings.compressedTexSubImage3D, .{ .name = "glCompressedTexSubImage3D", .linkage = linkage });
    @export(&bindings.compressedTexSubImage2D, .{ .name = "glCompressedTexSubImage2D", .linkage = linkage });
    @export(&bindings.compressedTexSubImage1D, .{ .name = "glCompressedTexSubImage1D", .linkage = linkage });
    @export(&bindings.getCompressedTexImage, .{ .name = "glGetCompressedTexImage", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 1.4 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.blendFuncSeparate, .{ .name = "glBlendFuncSeparate", .linkage = linkage });
    @export(&bindings.multiDrawArrays, .{ .name = "glMultiDrawArrays", .linkage = linkage });
    @export(&bindings.multiDrawElements, .{ .name = "glMultiDrawElements", .linkage = linkage });
    @export(&bindings.pointParameterf, .{ .name = "glPointParameterf", .linkage = linkage });
    @export(&bindings.pointParameterfv, .{ .name = "glPointParameterfv", .linkage = linkage });
    @export(&bindings.pointParameteri, .{ .name = "glPointParameteri", .linkage = linkage });
    @export(&bindings.pointParameteriv, .{ .name = "glPointParameteriv", .linkage = linkage });
    @export(&bindings.blendColor, .{ .name = "glBlendColor", .linkage = linkage });
    @export(&bindings.blendEquation, .{ .name = "glBlendEquation", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 1.5 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.genQueries, .{ .name = "glGenQueries", .linkage = linkage });
    @export(&bindings.deleteQueries, .{ .name = "glDeleteQueries", .linkage = linkage });
    @export(&bindings.isQuery, .{ .name = "glIsQuery", .linkage = linkage });
    @export(&bindings.beginQuery, .{ .name = "glBeginQuery", .linkage = linkage });
    @export(&bindings.endQuery, .{ .name = "glEndQuery", .linkage = linkage });
    @export(&bindings.getQueryiv, .{ .name = "glGetQueryiv", .linkage = linkage });
    @export(&bindings.getQueryObjectiv, .{ .name = "glGetQueryObjectiv", .linkage = linkage });
    @export(&bindings.getQueryObjectuiv, .{ .name = "glGetQueryObjectuiv", .linkage = linkage });
    @export(&bindings.bindBuffer, .{ .name = "glBindBuffer", .linkage = linkage });
    @export(&bindings.deleteBuffers, .{ .name = "glDeleteBuffers", .linkage = linkage });
    @export(&bindings.genBuffers, .{ .name = "glGenBuffers", .linkage = linkage });
    @export(&bindings.isBuffer, .{ .name = "glIsBuffer", .linkage = linkage });
    @export(&bindings.bufferData, .{ .name = "glBufferData", .linkage = linkage });
    @export(&bindings.bufferSubData, .{ .name = "glBufferSubData", .linkage = linkage });
    @export(&bindings.getBufferSubData, .{ .name = "glGetBufferSubData", .linkage = linkage });
    @export(&bindings.mapBuffer, .{ .name = "glMapBuffer", .linkage = linkage });
    @export(&bindings.unmapBuffer, .{ .name = "glUnmapBuffer", .linkage = linkage });
    @export(&bindings.getBufferParameteriv, .{ .name = "glGetBufferParameteriv", .linkage = linkage });
    @export(&bindings.getBufferPointerv, .{ .name = "glGetBufferPointerv", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 2.0 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.blendEquationSeparate, .{ .name = "glBlendEquationSeparate", .linkage = linkage });
    @export(&bindings.drawBuffers, .{ .name = "glDrawBuffers", .linkage = linkage });
    @export(&bindings.stencilOpSeparate, .{ .name = "glStencilOpSeparate", .linkage = linkage });
    @export(&bindings.stencilFuncSeparate, .{ .name = "glStencilFuncSeparate", .linkage = linkage });
    @export(&bindings.stencilMaskSeparate, .{ .name = "glStencilMaskSeparate", .linkage = linkage });
    @export(&bindings.attachShader, .{ .name = "glAttachShader", .linkage = linkage });
    @export(&bindings.bindAttribLocation, .{ .name = "glBindAttribLocation", .linkage = linkage });
    @export(&bindings.compileShader, .{ .name = "glCompileShader", .linkage = linkage });
    @export(&bindings.createProgram, .{ .name = "glCreateProgram", .linkage = linkage });
    @export(&bindings.createShader, .{ .name = "glCreateShader", .linkage = linkage });
    @export(&bindings.deleteProgram, .{ .name = "glDeleteProgram", .linkage = linkage });
    @export(&bindings.deleteShader, .{ .name = "glDeleteShader", .linkage = linkage });
    @export(&bindings.detachShader, .{ .name = "glDetachShader", .linkage = linkage });
    @export(&bindings.disableVertexAttribArray, .{ .name = "glDisableVertexAttribArray", .linkage = linkage });
    @export(&bindings.enableVertexAttribArray, .{ .name = "glEnableVertexAttribArray", .linkage = linkage });
    @export(&bindings.getActiveAttrib, .{ .name = "glGetActiveAttrib", .linkage = linkage });
    @export(&bindings.getActiveUniform, .{ .name = "glGetActiveUniform", .linkage = linkage });
    @export(&bindings.getAttachedShaders, .{ .name = "glGetAttachedShaders", .linkage = linkage });
    @export(&bindings.getAttribLocation, .{ .name = "glGetAttribLocation", .linkage = linkage });
    @export(&bindings.getProgramiv, .{ .name = "glGetProgramiv", .linkage = linkage });
    @export(&bindings.getProgramInfoLog, .{ .name = "glGetProgramInfoLog", .linkage = linkage });
    @export(&bindings.getShaderiv, .{ .name = "glGetShaderiv", .linkage = linkage });
    @export(&bindings.getShaderInfoLog, .{ .name = "glGetShaderInfoLog", .linkage = linkage });
    @export(&bindings.getShaderSource, .{ .name = "glGetShaderSource", .linkage = linkage });
    @export(&bindings.getUniformLocation, .{ .name = "glGetUniformLocation", .linkage = linkage });
    @export(&bindings.getUniformfv, .{ .name = "glGetUniformfv", .linkage = linkage });
    @export(&bindings.getUniformiv, .{ .name = "glGetUniformiv", .linkage = linkage });
    @export(&bindings.getVertexAttribdv, .{ .name = "glGetVertexAttribdv", .linkage = linkage });
    @export(&bindings.getVertexAttribfv, .{ .name = "glGetVertexAttribfv", .linkage = linkage });
    @export(&bindings.getVertexAttribiv, .{ .name = "glGetVertexAttribiv", .linkage = linkage });
    @export(&bindings.getVertexAttribPointerv, .{ .name = "glGetVertexAttribPointerv", .linkage = linkage });
    @export(&bindings.isProgram, .{ .name = "glIsProgram", .linkage = linkage });
    @export(&bindings.isShader, .{ .name = "glIsShader", .linkage = linkage });
    @export(&bindings.linkProgram, .{ .name = "glLinkProgram", .linkage = linkage });
    @export(&bindings.shaderSource, .{ .name = "glShaderSource", .linkage = linkage });
    @export(&bindings.useProgram, .{ .name = "glUseProgram", .linkage = linkage });
    @export(&bindings.uniform1f, .{ .name = "glUniform1f", .linkage = linkage });
    @export(&bindings.uniform2f, .{ .name = "glUniform2f", .linkage = linkage });
    @export(&bindings.uniform3f, .{ .name = "glUniform3f", .linkage = linkage });
    @export(&bindings.uniform4f, .{ .name = "glUniform4f", .linkage = linkage });
    @export(&bindings.uniform1i, .{ .name = "glUniform1i", .linkage = linkage });
    @export(&bindings.uniform2i, .{ .name = "glUniform2i", .linkage = linkage });
    @export(&bindings.uniform3i, .{ .name = "glUniform3i", .linkage = linkage });
    @export(&bindings.uniform4i, .{ .name = "glUniform4i", .linkage = linkage });
    @export(&bindings.uniform1fv, .{ .name = "glUniform1fv", .linkage = linkage });
    @export(&bindings.uniform2fv, .{ .name = "glUniform2fv", .linkage = linkage });
    @export(&bindings.uniform3fv, .{ .name = "glUniform3fv", .linkage = linkage });
    @export(&bindings.uniform4fv, .{ .name = "glUniform4fv", .linkage = linkage });
    @export(&bindings.uniform1iv, .{ .name = "glUniform1iv", .linkage = linkage });
    @export(&bindings.uniform2iv, .{ .name = "glUniform2iv", .linkage = linkage });
    @export(&bindings.uniform3iv, .{ .name = "glUniform3iv", .linkage = linkage });
    @export(&bindings.uniform4iv, .{ .name = "glUniform4iv", .linkage = linkage });
    @export(&bindings.uniformMatrix2fv, .{ .name = "glUniformMatrix2fv", .linkage = linkage });
    @export(&bindings.uniformMatrix3fv, .{ .name = "glUniformMatrix3fv", .linkage = linkage });
    @export(&bindings.uniformMatrix4fv, .{ .name = "glUniformMatrix4fv", .linkage = linkage });
    @export(&bindings.validateProgram, .{ .name = "glValidateProgram", .linkage = linkage });
    @export(&bindings.vertexAttrib1d, .{ .name = "glVertexAttrib1d", .linkage = linkage });
    @export(&bindings.vertexAttrib1dv, .{ .name = "glVertexAttrib1dv", .linkage = linkage });
    @export(&bindings.vertexAttrib1f, .{ .name = "glVertexAttrib1f", .linkage = linkage });
    @export(&bindings.vertexAttrib1fv, .{ .name = "glVertexAttrib1fv", .linkage = linkage });
    @export(&bindings.vertexAttrib1s, .{ .name = "glVertexAttrib1s", .linkage = linkage });
    @export(&bindings.vertexAttrib1sv, .{ .name = "glVertexAttrib1sv", .linkage = linkage });
    @export(&bindings.vertexAttrib2d, .{ .name = "glVertexAttrib2d", .linkage = linkage });
    @export(&bindings.vertexAttrib2dv, .{ .name = "glVertexAttrib2dv", .linkage = linkage });
    @export(&bindings.vertexAttrib2f, .{ .name = "glVertexAttrib2f", .linkage = linkage });
    @export(&bindings.vertexAttrib2fv, .{ .name = "glVertexAttrib2fv", .linkage = linkage });
    @export(&bindings.vertexAttrib2s, .{ .name = "glVertexAttrib2s", .linkage = linkage });
    @export(&bindings.vertexAttrib2sv, .{ .name = "glVertexAttrib2sv", .linkage = linkage });
    @export(&bindings.vertexAttrib3d, .{ .name = "glVertexAttrib3d", .linkage = linkage });
    @export(&bindings.vertexAttrib3dv, .{ .name = "glVertexAttrib3dv", .linkage = linkage });
    @export(&bindings.vertexAttrib3f, .{ .name = "glVertexAttrib3f", .linkage = linkage });
    @export(&bindings.vertexAttrib3fv, .{ .name = "glVertexAttrib3fv", .linkage = linkage });
    @export(&bindings.vertexAttrib3s, .{ .name = "glVertexAttrib3s", .linkage = linkage });
    @export(&bindings.vertexAttrib3sv, .{ .name = "glVertexAttrib3sv", .linkage = linkage });
    @export(&bindings.vertexAttrib4Nbv, .{ .name = "glVertexAttrib4Nbv", .linkage = linkage });
    @export(&bindings.vertexAttrib4Niv, .{ .name = "glVertexAttrib4Niv", .linkage = linkage });
    @export(&bindings.vertexAttrib4Nsv, .{ .name = "glVertexAttrib4Nsv", .linkage = linkage });
    @export(&bindings.vertexAttrib4Nub, .{ .name = "glVertexAttrib4Nub", .linkage = linkage });
    @export(&bindings.vertexAttrib4Nubv, .{ .name = "glVertexAttrib4Nubv", .linkage = linkage });
    @export(&bindings.vertexAttrib4Nuiv, .{ .name = "glVertexAttrib4Nuiv", .linkage = linkage });
    @export(&bindings.vertexAttrib4Nusv, .{ .name = "glVertexAttrib4Nusv", .linkage = linkage });
    @export(&bindings.vertexAttrib4bv, .{ .name = "glVertexAttrib4bv", .linkage = linkage });
    @export(&bindings.vertexAttrib4d, .{ .name = "glVertexAttrib4d", .linkage = linkage });
    @export(&bindings.vertexAttrib4dv, .{ .name = "glVertexAttrib4dv", .linkage = linkage });
    @export(&bindings.vertexAttrib4f, .{ .name = "glVertexAttrib4f", .linkage = linkage });
    @export(&bindings.vertexAttrib4fv, .{ .name = "glVertexAttrib4fv", .linkage = linkage });
    @export(&bindings.vertexAttrib4iv, .{ .name = "glVertexAttrib4iv", .linkage = linkage });
    @export(&bindings.vertexAttrib4s, .{ .name = "glVertexAttrib4s", .linkage = linkage });
    @export(&bindings.vertexAttrib4sv, .{ .name = "glVertexAttrib4sv", .linkage = linkage });
    @export(&bindings.vertexAttrib4ubv, .{ .name = "glVertexAttrib4ubv", .linkage = linkage });
    @export(&bindings.vertexAttrib4uiv, .{ .name = "glVertexAttrib4uiv", .linkage = linkage });
    @export(&bindings.vertexAttrib4usv, .{ .name = "glVertexAttrib4usv", .linkage = linkage });
    @export(&bindings.vertexAttribPointer, .{ .name = "glVertexAttribPointer", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 2.1 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.uniformMatrix2x3fv, .{ .name = "glUniformMatrix2x3fv", .linkage = linkage });
    @export(&bindings.uniformMatrix3x2fv, .{ .name = "glUniformMatrix3x2fv", .linkage = linkage });
    @export(&bindings.uniformMatrix2x4fv, .{ .name = "glUniformMatrix2x4fv", .linkage = linkage });
    @export(&bindings.uniformMatrix4x2fv, .{ .name = "glUniformMatrix4x2fv", .linkage = linkage });
    @export(&bindings.uniformMatrix3x4fv, .{ .name = "glUniformMatrix3x4fv", .linkage = linkage });
    @export(&bindings.uniformMatrix4x3fv, .{ .name = "glUniformMatrix4x3fv", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 3.0 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.colorMaski, .{ .name = "glColorMaski", .linkage = linkage });
    @export(&bindings.getBooleani_v, .{ .name = "glGetBooleani_v", .linkage = linkage });
    @export(&bindings.getIntegeri_v, .{ .name = "glGetIntegeri_v", .linkage = linkage });
    @export(&bindings.enablei, .{ .name = "glEnablei", .linkage = linkage });
    @export(&bindings.disablei, .{ .name = "glDisablei", .linkage = linkage });
    @export(&bindings.isEnabledi, .{ .name = "glIsEnabledi", .linkage = linkage });
    @export(&bindings.beginTransformFeedback, .{ .name = "glBeginTransformFeedback", .linkage = linkage });
    @export(&bindings.endTransformFeedback, .{ .name = "glEndTransformFeedback", .linkage = linkage });
    @export(&bindings.bindBufferRange, .{ .name = "glBindBufferRange", .linkage = linkage });
    @export(&bindings.bindBufferBase, .{ .name = "glBindBufferBase", .linkage = linkage });
    @export(&bindings.transformFeedbackVaryings, .{ .name = "glTransformFeedbackVaryings", .linkage = linkage });
    @export(&bindings.getTransformFeedbackVarying, .{ .name = "glGetTransformFeedbackVarying", .linkage = linkage });
    @export(&bindings.clampColor, .{ .name = "glClampColor", .linkage = linkage });
    @export(&bindings.beginConditionalRender, .{ .name = "glBeginConditionalRender", .linkage = linkage });
    @export(&bindings.endConditionalRender, .{ .name = "glEndConditionalRender", .linkage = linkage });
    @export(&bindings.vertexAttribIPointer, .{ .name = "glVertexAttribIPointer", .linkage = linkage });
    @export(&bindings.getVertexAttribIiv, .{ .name = "glGetVertexAttribIiv", .linkage = linkage });
    @export(&bindings.getVertexAttribIuiv, .{ .name = "glGetVertexAttribIuiv", .linkage = linkage });
    @export(&bindings.vertexAttribI1i, .{ .name = "glVertexAttribI1i", .linkage = linkage });
    @export(&bindings.vertexAttribI2i, .{ .name = "glVertexAttribI2i", .linkage = linkage });
    @export(&bindings.vertexAttribI3i, .{ .name = "glVertexAttribI3i", .linkage = linkage });
    @export(&bindings.vertexAttribI4i, .{ .name = "glVertexAttribI4i", .linkage = linkage });
    @export(&bindings.vertexAttribI1ui, .{ .name = "glVertexAttribI1ui", .linkage = linkage });
    @export(&bindings.vertexAttribI2ui, .{ .name = "glVertexAttribI2ui", .linkage = linkage });
    @export(&bindings.vertexAttribI3ui, .{ .name = "glVertexAttribI3ui", .linkage = linkage });
    @export(&bindings.vertexAttribI4ui, .{ .name = "glVertexAttribI4ui", .linkage = linkage });
    @export(&bindings.vertexAttribI1iv, .{ .name = "glVertexAttribI1iv", .linkage = linkage });
    @export(&bindings.vertexAttribI2iv, .{ .name = "glVertexAttribI2iv", .linkage = linkage });
    @export(&bindings.vertexAttribI3iv, .{ .name = "glVertexAttribI3iv", .linkage = linkage });
    @export(&bindings.vertexAttribI4iv, .{ .name = "glVertexAttribI4iv", .linkage = linkage });
    @export(&bindings.vertexAttribI1uiv, .{ .name = "glVertexAttribI1uiv", .linkage = linkage });
    @export(&bindings.vertexAttribI2uiv, .{ .name = "glVertexAttribI2uiv", .linkage = linkage });
    @export(&bindings.vertexAttribI3uiv, .{ .name = "glVertexAttribI3uiv", .linkage = linkage });
    @export(&bindings.vertexAttribI4uiv, .{ .name = "glVertexAttribI4uiv", .linkage = linkage });
    @export(&bindings.vertexAttribI4bv, .{ .name = "glVertexAttribI4bv", .linkage = linkage });
    @export(&bindings.vertexAttribI4sv, .{ .name = "glVertexAttribI4sv", .linkage = linkage });
    @export(&bindings.vertexAttribI4ubv, .{ .name = "glVertexAttribI4ubv", .linkage = linkage });
    @export(&bindings.vertexAttribI4usv, .{ .name = "glVertexAttribI4usv", .linkage = linkage });
    @export(&bindings.getUniformuiv, .{ .name = "glGetUniformuiv", .linkage = linkage });
    @export(&bindings.bindFragDataLocation, .{ .name = "glBindFragDataLocation", .linkage = linkage });
    @export(&bindings.getFragDataLocation, .{ .name = "glGetFragDataLocation", .linkage = linkage });
    @export(&bindings.uniform1ui, .{ .name = "glUniform1ui", .linkage = linkage });
    @export(&bindings.uniform2ui, .{ .name = "glUniform2ui", .linkage = linkage });
    @export(&bindings.uniform3ui, .{ .name = "glUniform3ui", .linkage = linkage });
    @export(&bindings.uniform4ui, .{ .name = "glUniform4ui", .linkage = linkage });
    @export(&bindings.uniform1uiv, .{ .name = "glUniform1uiv", .linkage = linkage });
    @export(&bindings.uniform2uiv, .{ .name = "glUniform2uiv", .linkage = linkage });
    @export(&bindings.uniform3uiv, .{ .name = "glUniform3uiv", .linkage = linkage });
    @export(&bindings.uniform4uiv, .{ .name = "glUniform4uiv", .linkage = linkage });
    @export(&bindings.texParameterIiv, .{ .name = "glTexParameterIiv", .linkage = linkage });
    @export(&bindings.texParameterIuiv, .{ .name = "glTexParameterIuiv", .linkage = linkage });
    @export(&bindings.getTexParameterIiv, .{ .name = "glGetTexParameterIiv", .linkage = linkage });
    @export(&bindings.getTexParameterIuiv, .{ .name = "glGetTexParameterIuiv", .linkage = linkage });
    @export(&bindings.clearBufferiv, .{ .name = "glClearBufferiv", .linkage = linkage });
    @export(&bindings.clearBufferuiv, .{ .name = "glClearBufferuiv", .linkage = linkage });
    @export(&bindings.clearBufferfv, .{ .name = "glClearBufferfv", .linkage = linkage });
    @export(&bindings.clearBufferfi, .{ .name = "glClearBufferfi", .linkage = linkage });
    @export(&bindings.getStringi, .{ .name = "glGetStringi", .linkage = linkage });
    @export(&bindings.isRenderbuffer, .{ .name = "glIsRenderbuffer", .linkage = linkage });
    @export(&bindings.bindRenderbuffer, .{ .name = "glBindRenderbuffer", .linkage = linkage });
    @export(&bindings.deleteRenderbuffers, .{ .name = "glDeleteRenderbuffers", .linkage = linkage });
    @export(&bindings.genRenderbuffers, .{ .name = "glGenRenderbuffers", .linkage = linkage });
    @export(&bindings.renderbufferStorage, .{ .name = "glRenderbufferStorage", .linkage = linkage });
    @export(&bindings.getRenderbufferParameteriv, .{ .name = "glGetRenderbufferParameteriv", .linkage = linkage });
    @export(&bindings.isFramebuffer, .{ .name = "glIsFramebuffer", .linkage = linkage });
    @export(&bindings.bindFramebuffer, .{ .name = "glBindFramebuffer", .linkage = linkage });
    @export(&bindings.deleteFramebuffers, .{ .name = "glDeleteFramebuffers", .linkage = linkage });
    @export(&bindings.genFramebuffers, .{ .name = "glGenFramebuffers", .linkage = linkage });
    @export(&bindings.checkFramebufferStatus, .{ .name = "glCheckFramebufferStatus", .linkage = linkage });
    @export(&bindings.framebufferTexture1D, .{ .name = "glFramebufferTexture1D", .linkage = linkage });
    @export(&bindings.framebufferTexture2D, .{ .name = "glFramebufferTexture2D", .linkage = linkage });
    @export(&bindings.framebufferTexture3D, .{ .name = "glFramebufferTexture3D", .linkage = linkage });
    @export(&bindings.framebufferRenderbuffer, .{ .name = "glFramebufferRenderbuffer", .linkage = linkage });
    @export(&bindings.getFramebufferAttachmentParameteriv, .{ .name = "glGetFramebufferAttachmentParameteriv", .linkage = linkage });
    @export(&bindings.generateMipmap, .{ .name = "glGenerateMipmap", .linkage = linkage });
    @export(&bindings.blitFramebuffer, .{ .name = "glBlitFramebuffer", .linkage = linkage });
    @export(&bindings.renderbufferStorageMultisample, .{ .name = "glRenderbufferStorageMultisample", .linkage = linkage });
    @export(&bindings.framebufferTextureLayer, .{ .name = "glFramebufferTextureLayer", .linkage = linkage });
    @export(&bindings.mapBufferRange, .{ .name = "glMapBufferRange", .linkage = linkage });
    @export(&bindings.flushMappedBufferRange, .{ .name = "glFlushMappedBufferRange", .linkage = linkage });
    @export(&bindings.bindVertexArray, .{ .name = "glBindVertexArray", .linkage = linkage });
    @export(&bindings.deleteVertexArrays, .{ .name = "glDeleteVertexArrays", .linkage = linkage });
    @export(&bindings.genVertexArrays, .{ .name = "glGenVertexArrays", .linkage = linkage });
    @export(&bindings.isVertexArray, .{ .name = "glIsVertexArray", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 3.1 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.drawArraysInstanced, .{ .name = "glDrawArraysInstanced", .linkage = linkage });
    @export(&bindings.drawElementsInstanced, .{ .name = "glDrawElementsInstanced", .linkage = linkage });
    @export(&bindings.texBuffer, .{ .name = "glTexBuffer", .linkage = linkage });
    @export(&bindings.primitiveRestartIndex, .{ .name = "glPrimitiveRestartIndex", .linkage = linkage });
    @export(&bindings.copyBufferSubData, .{ .name = "glCopyBufferSubData", .linkage = linkage });
    @export(&bindings.getUniformIndices, .{ .name = "glGetUniformIndices", .linkage = linkage });
    @export(&bindings.getActiveUniformsiv, .{ .name = "glGetActiveUniformsiv", .linkage = linkage });
    @export(&bindings.getActiveUniformName, .{ .name = "glGetActiveUniformName", .linkage = linkage });
    @export(&bindings.getUniformBlockIndex, .{ .name = "glGetUniformBlockIndex", .linkage = linkage });
    @export(&bindings.getActiveUniformBlockiv, .{ .name = "glGetActiveUniformBlockiv", .linkage = linkage });
    @export(&bindings.getActiveUniformBlockName, .{ .name = "glGetActiveUniformBlockName", .linkage = linkage });
    @export(&bindings.uniformBlockBinding, .{ .name = "glUniformBlockBinding", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 3.2 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.drawElementsBaseVertex, .{ .name = "glDrawElementsBaseVertex", .linkage = linkage });
    @export(&bindings.drawRangeElementsBaseVertex, .{ .name = "glDrawRangeElementsBaseVertex", .linkage = linkage });
    @export(&bindings.drawElementsInstancedBaseVertex, .{ .name = "glDrawElementsInstancedBaseVertex", .linkage = linkage });
    @export(&bindings.multiDrawElementsBaseVertex, .{ .name = "glMultiDrawElementsBaseVertex", .linkage = linkage });
    @export(&bindings.provokingVertex, .{ .name = "glProvokingVertex", .linkage = linkage });
    @export(&bindings.fenceSync, .{ .name = "glFenceSync", .linkage = linkage });
    @export(&bindings.isSync, .{ .name = "glIsSync", .linkage = linkage });
    @export(&bindings.deleteSync, .{ .name = "glDeleteSync", .linkage = linkage });
    @export(&bindings.clientWaitSync, .{ .name = "glClientWaitSync", .linkage = linkage });
    @export(&bindings.waitSync, .{ .name = "glWaitSync", .linkage = linkage });
    @export(&bindings.getInteger64v, .{ .name = "glGetInteger64v", .linkage = linkage });
    @export(&bindings.getSynciv, .{ .name = "glGetSynciv", .linkage = linkage });
    @export(&bindings.getInteger64i_v, .{ .name = "glGetInteger64i_v", .linkage = linkage });
    @export(&bindings.getBufferParameteri64v, .{ .name = "glGetBufferParameteri64v", .linkage = linkage });
    @export(&bindings.framebufferTexture, .{ .name = "glFramebufferTexture", .linkage = linkage });
    @export(&bindings.texImage2DMultisample, .{ .name = "glTexImage2DMultisample", .linkage = linkage });
    @export(&bindings.texImage3DMultisample, .{ .name = "glTexImage3DMultisample", .linkage = linkage });
    @export(&bindings.getMultisamplefv, .{ .name = "glGetMultisamplefv", .linkage = linkage });
    @export(&bindings.sampleMaski, .{ .name = "glSampleMaski", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 3.3 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.bindFragDataLocationIndexed, .{ .name = "glBindFragDataLocationIndexed", .linkage = linkage });
    @export(&bindings.getFragDataIndex, .{ .name = "glGetFragDataIndex", .linkage = linkage });
    @export(&bindings.genSamplers, .{ .name = "glGenSamplers", .linkage = linkage });
    @export(&bindings.deleteSamplers, .{ .name = "glDeleteSamplers", .linkage = linkage });
    @export(&bindings.isSampler, .{ .name = "glIsSampler", .linkage = linkage });
    @export(&bindings.bindSampler, .{ .name = "glBindSampler", .linkage = linkage });
    @export(&bindings.samplerParameteri, .{ .name = "glSamplerParameteri", .linkage = linkage });
    @export(&bindings.samplerParameteriv, .{ .name = "glSamplerParameteriv", .linkage = linkage });
    @export(&bindings.samplerParameterf, .{ .name = "glSamplerParameterf", .linkage = linkage });
    @export(&bindings.samplerParameterfv, .{ .name = "glSamplerParameterfv", .linkage = linkage });
    @export(&bindings.samplerParameterIiv, .{ .name = "glSamplerParameterIiv", .linkage = linkage });
    @export(&bindings.samplerParameterIuiv, .{ .name = "glSamplerParameterIuiv", .linkage = linkage });
    @export(&bindings.getSamplerParameteriv, .{ .name = "glGetSamplerParameteriv", .linkage = linkage });
    @export(&bindings.getSamplerParameterIiv, .{ .name = "glGetSamplerParameterIiv", .linkage = linkage });
    @export(&bindings.getSamplerParameterfv, .{ .name = "glGetSamplerParameterfv", .linkage = linkage });
    @export(&bindings.getSamplerParameterIuiv, .{ .name = "glGetSamplerParameterIuiv", .linkage = linkage });
    @export(&bindings.queryCounter, .{ .name = "glQueryCounter", .linkage = linkage });
    @export(&bindings.getQueryObjecti64v, .{ .name = "glGetQueryObjecti64v", .linkage = linkage });
    @export(&bindings.getQueryObjectui64v, .{ .name = "glGetQueryObjectui64v", .linkage = linkage });
    @export(&bindings.vertexAttribDivisor, .{ .name = "glVertexAttribDivisor", .linkage = linkage });
    @export(&bindings.vertexAttribP1ui, .{ .name = "glVertexAttribP1ui", .linkage = linkage });
    @export(&bindings.vertexAttribP1uiv, .{ .name = "glVertexAttribP1uiv", .linkage = linkage });
    @export(&bindings.vertexAttribP2ui, .{ .name = "glVertexAttribP2ui", .linkage = linkage });
    @export(&bindings.vertexAttribP2uiv, .{ .name = "glVertexAttribP2uiv", .linkage = linkage });
    @export(&bindings.vertexAttribP3ui, .{ .name = "glVertexAttribP3ui", .linkage = linkage });
    @export(&bindings.vertexAttribP3uiv, .{ .name = "glVertexAttribP3uiv", .linkage = linkage });
    @export(&bindings.vertexAttribP4ui, .{ .name = "glVertexAttribP4ui", .linkage = linkage });
    @export(&bindings.vertexAttribP4uiv, .{ .name = "glVertexAttribP4uiv", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.0 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.minSampleShading, .{ .name = "glMinSampleShading", .linkage = linkage });
    @export(&bindings.blendEquationi, .{ .name = "glBlendEquationi", .linkage = linkage });
    @export(&bindings.blendEquationSeparatei, .{ .name = "glBlendEquationSeparatei", .linkage = linkage });
    @export(&bindings.blendFunci, .{ .name = "glBlendFunci", .linkage = linkage });
    @export(&bindings.blendFuncSeparatei, .{ .name = "glBlendFuncSeparatei", .linkage = linkage });
    @export(&bindings.drawArraysIndirect, .{ .name = "glDrawArraysIndirect", .linkage = linkage });
    @export(&bindings.drawElementsIndirect, .{ .name = "glDrawElementsIndirect", .linkage = linkage });
    @export(&bindings.uniform1d, .{ .name = "glUniform1d", .linkage = linkage });
    @export(&bindings.uniform2d, .{ .name = "glUniform2d", .linkage = linkage });
    @export(&bindings.uniform3d, .{ .name = "glUniform3d", .linkage = linkage });
    @export(&bindings.uniform4d, .{ .name = "glUniform4d", .linkage = linkage });
    @export(&bindings.uniform1dv, .{ .name = "glUniform1dv", .linkage = linkage });
    @export(&bindings.uniform2dv, .{ .name = "glUniform2dv", .linkage = linkage });
    @export(&bindings.uniform3dv, .{ .name = "glUniform3dv", .linkage = linkage });
    @export(&bindings.uniform4dv, .{ .name = "glUniform4dv", .linkage = linkage });
    @export(&bindings.uniformMatrix2dv, .{ .name = "glUniformMatrix2dv", .linkage = linkage });
    @export(&bindings.uniformMatrix3dv, .{ .name = "glUniformMatrix3dv", .linkage = linkage });
    @export(&bindings.uniformMatrix4dv, .{ .name = "glUniformMatrix4dv", .linkage = linkage });
    @export(&bindings.uniformMatrix2x3dv, .{ .name = "glUniformMatrix2x3dv", .linkage = linkage });
    @export(&bindings.uniformMatrix2x4dv, .{ .name = "glUniformMatrix2x4dv", .linkage = linkage });
    @export(&bindings.uniformMatrix3x2dv, .{ .name = "glUniformMatrix3x2dv", .linkage = linkage });
    @export(&bindings.uniformMatrix3x4dv, .{ .name = "glUniformMatrix3x4dv", .linkage = linkage });
    @export(&bindings.uniformMatrix4x2dv, .{ .name = "glUniformMatrix4x2dv", .linkage = linkage });
    @export(&bindings.uniformMatrix4x3dv, .{ .name = "glUniformMatrix4x3dv", .linkage = linkage });
    @export(&bindings.getUniformdv, .{ .name = "glGetUniformdv", .linkage = linkage });
    @export(&bindings.getSubroutineUniformLocation, .{ .name = "glGetSubroutineUniformLocation", .linkage = linkage });
    @export(&bindings.getSubroutineIndex, .{ .name = "glGetSubroutineIndex", .linkage = linkage });
    @export(&bindings.getActiveSubroutineUniformiv, .{ .name = "glGetActiveSubroutineUniformiv", .linkage = linkage });
    @export(&bindings.getActiveSubroutineUniformName, .{ .name = "glGetActiveSubroutineUniformName", .linkage = linkage });
    @export(&bindings.getActiveSubroutineName, .{ .name = "glGetActiveSubroutineName", .linkage = linkage });
    @export(&bindings.uniformSubroutinesuiv, .{ .name = "glUniformSubroutinesuiv", .linkage = linkage });
    @export(&bindings.getUniformSubroutineuiv, .{ .name = "glGetUniformSubroutineuiv", .linkage = linkage });
    @export(&bindings.getProgramStageiv, .{ .name = "glGetProgramStageiv", .linkage = linkage });
    @export(&bindings.patchParameteri, .{ .name = "glPatchParameteri", .linkage = linkage });
    @export(&bindings.patchParameterfv, .{ .name = "glPatchParameterfv", .linkage = linkage });
    @export(&bindings.bindTransformFeedback, .{ .name = "glBindTransformFeedback", .linkage = linkage });
    @export(&bindings.deleteTransformFeedbacks, .{ .name = "glDeleteTransformFeedbacks", .linkage = linkage });
    @export(&bindings.genTransformFeedbacks, .{ .name = "glGenTransformFeedbacks", .linkage = linkage });
    @export(&bindings.isTransformFeedback, .{ .name = "glIsTransformFeedback", .linkage = linkage });
    @export(&bindings.pauseTransformFeedback, .{ .name = "glPauseTransformFeedback", .linkage = linkage });
    @export(&bindings.resumeTransformFeedback, .{ .name = "glResumeTransformFeedback", .linkage = linkage });
    @export(&bindings.drawTransformFeedback, .{ .name = "glDrawTransformFeedback", .linkage = linkage });
    @export(&bindings.drawTransformFeedbackStream, .{ .name = "glDrawTransformFeedbackStream", .linkage = linkage });
    @export(&bindings.beginQueryIndexed, .{ .name = "glBeginQueryIndexed", .linkage = linkage });
    @export(&bindings.endQueryIndexed, .{ .name = "glEndQueryIndexed", .linkage = linkage });
    @export(&bindings.getQueryIndexediv, .{ .name = "glGetQueryIndexediv", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.1 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.releaseShaderCompiler, .{ .name = "glReleaseShaderCompiler", .linkage = linkage });
    @export(&bindings.shaderBinary, .{ .name = "glShaderBinary", .linkage = linkage });
    @export(&bindings.getShaderPrecisionFormat, .{ .name = "glGetShaderPrecisionFormat", .linkage = linkage });
    @export(&bindings.depthRangef, .{ .name = "glDepthRangef", .linkage = linkage });
    @export(&bindings.clearDepthf, .{ .name = "glClearDepthf", .linkage = linkage });
    @export(&bindings.getProgramBinary, .{ .name = "glGetProgramBinary", .linkage = linkage });
    @export(&bindings.programBinary, .{ .name = "glProgramBinary", .linkage = linkage });
    @export(&bindings.programParameteri, .{ .name = "glProgramParameteri", .linkage = linkage });
    @export(&bindings.useProgramStages, .{ .name = "glUseProgramStages", .linkage = linkage });
    @export(&bindings.activeShaderProgram, .{ .name = "glActiveShaderProgram", .linkage = linkage });
    @export(&bindings.createShaderProgramv, .{ .name = "glCreateShaderProgramv", .linkage = linkage });
    @export(&bindings.bindProgramPipeline, .{ .name = "glBindProgramPipeline", .linkage = linkage });
    @export(&bindings.deleteProgramPipelines, .{ .name = "glDeleteProgramPipelines", .linkage = linkage });
    @export(&bindings.genProgramPipelines, .{ .name = "glGenProgramPipelines", .linkage = linkage });
    @export(&bindings.isProgramPipeline, .{ .name = "glIsProgramPipeline", .linkage = linkage });
    @export(&bindings.getProgramPipelineiv, .{ .name = "glGetProgramPipelineiv", .linkage = linkage });
    @export(&bindings.programUniform1i, .{ .name = "glProgramUniform1i", .linkage = linkage });
    @export(&bindings.programUniform2i, .{ .name = "glProgramUniform2i", .linkage = linkage });
    @export(&bindings.programUniform3i, .{ .name = "glProgramUniform3i", .linkage = linkage });
    @export(&bindings.programUniform4i, .{ .name = "glProgramUniform4i", .linkage = linkage });
    @export(&bindings.programUniform1ui, .{ .name = "glProgramUniform1ui", .linkage = linkage });
    @export(&bindings.programUniform2ui, .{ .name = "glProgramUniform2ui", .linkage = linkage });
    @export(&bindings.programUniform3ui, .{ .name = "glProgramUniform3ui", .linkage = linkage });
    @export(&bindings.programUniform4ui, .{ .name = "glProgramUniform4ui", .linkage = linkage });
    @export(&bindings.programUniform1f, .{ .name = "glProgramUniform1f", .linkage = linkage });
    @export(&bindings.programUniform2f, .{ .name = "glProgramUniform2f", .linkage = linkage });
    @export(&bindings.programUniform3f, .{ .name = "glProgramUniform3f", .linkage = linkage });
    @export(&bindings.programUniform4f, .{ .name = "glProgramUniform4f", .linkage = linkage });
    @export(&bindings.programUniform1d, .{ .name = "glProgramUniform1d", .linkage = linkage });
    @export(&bindings.programUniform2d, .{ .name = "glProgramUniform2d", .linkage = linkage });
    @export(&bindings.programUniform3d, .{ .name = "glProgramUniform3d", .linkage = linkage });
    @export(&bindings.programUniform4d, .{ .name = "glProgramUniform4d", .linkage = linkage });
    @export(&bindings.programUniform1iv, .{ .name = "glProgramUniform1iv", .linkage = linkage });
    @export(&bindings.programUniform2iv, .{ .name = "glProgramUniform2iv", .linkage = linkage });
    @export(&bindings.programUniform3iv, .{ .name = "glProgramUniform3iv", .linkage = linkage });
    @export(&bindings.programUniform4iv, .{ .name = "glProgramUniform4iv", .linkage = linkage });
    @export(&bindings.programUniform1uiv, .{ .name = "glProgramUniform1uiv", .linkage = linkage });
    @export(&bindings.programUniform2uiv, .{ .name = "glProgramUniform2uiv", .linkage = linkage });
    @export(&bindings.programUniform3uiv, .{ .name = "glProgramUniform3uiv", .linkage = linkage });
    @export(&bindings.programUniform4uiv, .{ .name = "glProgramUniform4uiv", .linkage = linkage });
    @export(&bindings.programUniform1fv, .{ .name = "glProgramUniform1fv", .linkage = linkage });
    @export(&bindings.programUniform2fv, .{ .name = "glProgramUniform2fv", .linkage = linkage });
    @export(&bindings.programUniform3fv, .{ .name = "glProgramUniform3fv", .linkage = linkage });
    @export(&bindings.programUniform4fv, .{ .name = "glProgramUniform4fv", .linkage = linkage });
    @export(&bindings.programUniform1dv, .{ .name = "glProgramUniform1dv", .linkage = linkage });
    @export(&bindings.programUniform2dv, .{ .name = "glProgramUniform2dv", .linkage = linkage });
    @export(&bindings.programUniform3dv, .{ .name = "glProgramUniform3dv", .linkage = linkage });
    @export(&bindings.programUniform4dv, .{ .name = "glProgramUniform4dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix2fv, .{ .name = "glProgramUniformMatrix2fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix3fv, .{ .name = "glProgramUniformMatrix3fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix4fv, .{ .name = "glProgramUniformMatrix4fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix2dv, .{ .name = "glProgramUniformMatrix2dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix3dv, .{ .name = "glProgramUniformMatrix3dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix4dv, .{ .name = "glProgramUniformMatrix4dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix2x3fv, .{ .name = "glProgramUniformMatrix2x3fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix3x2fv, .{ .name = "glProgramUniformMatrix3x2fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix2x4fv, .{ .name = "glProgramUniformMatrix2x4fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix4x2fv, .{ .name = "glProgramUniformMatrix4x2fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix3x4fv, .{ .name = "glProgramUniformMatrix3x4fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix4x3fv, .{ .name = "glProgramUniformMatrix4x3fv", .linkage = linkage });
    @export(&bindings.programUniformMatrix2x3dv, .{ .name = "glProgramUniformMatrix2x3dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix3x2dv, .{ .name = "glProgramUniformMatrix3x2dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix2x4dv, .{ .name = "glProgramUniformMatrix2x4dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix4x2dv, .{ .name = "glProgramUniformMatrix4x2dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix3x4dv, .{ .name = "glProgramUniformMatrix3x4dv", .linkage = linkage });
    @export(&bindings.programUniformMatrix4x3dv, .{ .name = "glProgramUniformMatrix4x3dv", .linkage = linkage });
    @export(&bindings.validateProgramPipeline, .{ .name = "glValidateProgramPipeline", .linkage = linkage });
    @export(&bindings.getProgramPipelineInfoLog, .{ .name = "glGetProgramPipelineInfoLog", .linkage = linkage });
    @export(&bindings.vertexAttribL1d, .{ .name = "glVertexAttribL1d", .linkage = linkage });
    @export(&bindings.vertexAttribL2d, .{ .name = "glVertexAttribL2d", .linkage = linkage });
    @export(&bindings.vertexAttribL3d, .{ .name = "glVertexAttribL3d", .linkage = linkage });
    @export(&bindings.vertexAttribL4d, .{ .name = "glVertexAttribL4d", .linkage = linkage });
    @export(&bindings.vertexAttribL1dv, .{ .name = "glVertexAttribL1dv", .linkage = linkage });
    @export(&bindings.vertexAttribL2dv, .{ .name = "glVertexAttribL2dv", .linkage = linkage });
    @export(&bindings.vertexAttribL3dv, .{ .name = "glVertexAttribL3dv", .linkage = linkage });
    @export(&bindings.vertexAttribL4dv, .{ .name = "glVertexAttribL4dv", .linkage = linkage });
    @export(&bindings.viewportArrayv, .{ .name = "glViewportArrayv", .linkage = linkage });
    @export(&bindings.viewportIndexedf, .{ .name = "glViewportIndexedf", .linkage = linkage });
    @export(&bindings.viewportIndexedfv, .{ .name = "glViewportIndexedfv", .linkage = linkage });
    @export(&bindings.scissorArrayv, .{ .name = "glScissorArrayv", .linkage = linkage });
    @export(&bindings.scissorIndexed, .{ .name = "glScissorIndexed", .linkage = linkage });
    @export(&bindings.scissorIndexedv, .{ .name = "glScissorIndexedv", .linkage = linkage });
    @export(&bindings.depthRangeArrayv, .{ .name = "glDepthRangeArrayv", .linkage = linkage });
    @export(&bindings.depthRangeIndexed, .{ .name = "glDepthRangeIndexed", .linkage = linkage });
    @export(&bindings.getFloati_v, .{ .name = "glGetFloati_v", .linkage = linkage });
    @export(&bindings.getDoublei_v, .{ .name = "glGetDoublei_v", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.2 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.drawArraysInstancedBaseInstance, .{ .name = "glDrawArraysInstancedBaseInstance", .linkage = linkage });
    @export(&bindings.drawElementsInstancedBaseInstance, .{ .name = "glDrawElementsInstancedBaseInstance", .linkage = linkage });
    @export(&bindings.drawElementsInstancedBaseVertexBaseInstance, .{ .name = "glDrawElementsInstancedBaseVertexBaseInstance", .linkage = linkage });
    @export(&bindings.getInternalformativ, .{ .name = "glGetInternalformativ", .linkage = linkage });
    @export(&bindings.getActiveAtomicCounterBufferiv, .{ .name = "glGetActiveAtomicCounterBufferiv", .linkage = linkage });
    @export(&bindings.bindImageTexture, .{ .name = "glBindImageTexture", .linkage = linkage });
    @export(&bindings.memoryBarrier, .{ .name = "glMemoryBarrier", .linkage = linkage });
    @export(&bindings.texStorage1D, .{ .name = "glTexStorage1D", .linkage = linkage });
    @export(&bindings.texStorage2D, .{ .name = "glTexStorage2D", .linkage = linkage });
    @export(&bindings.texStorage3D, .{ .name = "glTexStorage3D", .linkage = linkage });
    @export(&bindings.drawTransformFeedbackInstanced, .{ .name = "glDrawTransformFeedbackInstanced", .linkage = linkage });
    @export(&bindings.drawTransformFeedbackStreamInstanced, .{ .name = "glDrawTransformFeedbackStreamInstanced", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.3 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.clearBufferData, .{ .name = "glClearBufferData", .linkage = linkage });
    @export(&bindings.clearBufferSubData, .{ .name = "glClearBufferSubData", .linkage = linkage });
    @export(&bindings.dispatchCompute, .{ .name = "glDispatchCompute", .linkage = linkage });
    @export(&bindings.dispatchComputeIndirect, .{ .name = "glDispatchComputeIndirect", .linkage = linkage });
    @export(&bindings.copyImageSubData, .{ .name = "glCopyImageSubData", .linkage = linkage });
    @export(&bindings.framebufferParameteri, .{ .name = "glFramebufferParameteri", .linkage = linkage });
    @export(&bindings.getFramebufferParameteriv, .{ .name = "glGetFramebufferParameteriv", .linkage = linkage });
    @export(&bindings.getInternalformati64v, .{ .name = "glGetInternalformati64v", .linkage = linkage });
    @export(&bindings.invalidateTexSubImage, .{ .name = "glInvalidateTexSubImage", .linkage = linkage });
    @export(&bindings.invalidateTexImage, .{ .name = "glInvalidateTexImage", .linkage = linkage });
    @export(&bindings.invalidateBufferSubData, .{ .name = "glInvalidateBufferSubData", .linkage = linkage });
    @export(&bindings.invalidateBufferData, .{ .name = "glInvalidateBufferData", .linkage = linkage });
    @export(&bindings.invalidateFramebuffer, .{ .name = "glInvalidateFramebuffer", .linkage = linkage });
    @export(&bindings.invalidateSubFramebuffer, .{ .name = "glInvalidateSubFramebuffer", .linkage = linkage });
    @export(&bindings.multiDrawArraysIndirect, .{ .name = "glMultiDrawArraysIndirect", .linkage = linkage });
    @export(&bindings.multiDrawElementsIndirect, .{ .name = "glMultiDrawElementsIndirect", .linkage = linkage });
    @export(&bindings.getProgramInterfaceiv, .{ .name = "glGetProgramInterfaceiv", .linkage = linkage });
    @export(&bindings.getProgramResourceIndex, .{ .name = "glGetProgramResourceIndex", .linkage = linkage });
    @export(&bindings.getProgramResourceName, .{ .name = "glGetProgramResourceName", .linkage = linkage });
    @export(&bindings.getProgramResourceiv, .{ .name = "glGetProgramResourceiv", .linkage = linkage });
    @export(&bindings.getProgramResourceLocation, .{ .name = "glGetProgramResourceLocation", .linkage = linkage });
    @export(&bindings.getProgramResourceLocationIndex, .{ .name = "glGetProgramResourceLocationIndex", .linkage = linkage });
    @export(&bindings.shaderStorageBlockBinding, .{ .name = "glShaderStorageBlockBinding", .linkage = linkage });
    @export(&bindings.texBufferRange, .{ .name = "glTexBufferRange", .linkage = linkage });
    @export(&bindings.texStorage2DMultisample, .{ .name = "glTexStorage2DMultisample", .linkage = linkage });
    @export(&bindings.texStorage3DMultisample, .{ .name = "glTexStorage3DMultisample", .linkage = linkage });
    @export(&bindings.textureView, .{ .name = "glTextureView", .linkage = linkage });
    @export(&bindings.bindVertexBuffer, .{ .name = "glBindVertexBuffer", .linkage = linkage });
    @export(&bindings.vertexAttribFormat, .{ .name = "glVertexAttribFormat", .linkage = linkage });
    @export(&bindings.vertexAttribIFormat, .{ .name = "glVertexAttribIFormat", .linkage = linkage });
    @export(&bindings.vertexAttribLFormat, .{ .name = "glVertexAttribLFormat", .linkage = linkage });
    @export(&bindings.vertexAttribBinding, .{ .name = "glVertexAttribBinding", .linkage = linkage });
    @export(&bindings.vertexBindingDivisor, .{ .name = "glVertexBindingDivisor", .linkage = linkage });
    @export(&bindings.debugMessageControl, .{ .name = "glDebugMessageControl", .linkage = linkage });
    @export(&bindings.debugMessageInsert, .{ .name = "glDebugMessageInsert", .linkage = linkage });
    @export(&bindings.debugMessageCallback, .{ .name = "glDebugMessageCallback", .linkage = linkage });
    @export(&bindings.getDebugMessageLog, .{ .name = "glGetDebugMessageLog", .linkage = linkage });
    @export(&bindings.pushDebugGroup, .{ .name = "glPushDebugGroup", .linkage = linkage });
    @export(&bindings.popDebugGroup, .{ .name = "glPopDebugGroup", .linkage = linkage });
    @export(&bindings.objectLabel, .{ .name = "glObjectLabel", .linkage = linkage });
    @export(&bindings.getObjectLabel, .{ .name = "glGetObjectLabel", .linkage = linkage });
    @export(&bindings.objectPtrLabel, .{ .name = "glObjectPtrLabel", .linkage = linkage });
    @export(&bindings.getObjectPtrLabel, .{ .name = "glGetObjectPtrLabel", .linkage = linkage });
    @export(&bindings.getPointerv, .{ .name = "glGetPointerv", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.4 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.bufferStorage, .{ .name = "glBufferStorage", .linkage = linkage });
    @export(&bindings.clearTexImage, .{ .name = "glClearTexImage", .linkage = linkage });
    @export(&bindings.clearTexSubImage, .{ .name = "glClearTexSubImage", .linkage = linkage });
    @export(&bindings.bindBuffersBase, .{ .name = "glBindBuffersBase", .linkage = linkage });
    @export(&bindings.bindBuffersRange, .{ .name = "glBindBuffersRange", .linkage = linkage });
    @export(&bindings.bindTextures, .{ .name = "glBindTextures", .linkage = linkage });
    @export(&bindings.bindSamplers, .{ .name = "glBindSamplers", .linkage = linkage });
    @export(&bindings.bindImageTextures, .{ .name = "glBindImageTextures", .linkage = linkage });
    @export(&bindings.bindVertexBuffers, .{ .name = "glBindVertexBuffers", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.5 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.clipControl, .{ .name = "glClipControl", .linkage = linkage });
    @export(&bindings.createTransformFeedbacks, .{ .name = "glCreateTransformFeedbacks", .linkage = linkage });
    @export(&bindings.transformFeedbackBufferBase, .{ .name = "glTransformFeedbackBufferBase", .linkage = linkage });
    @export(&bindings.transformFeedbackBufferRange, .{ .name = "glTransformFeedbackBufferRange", .linkage = linkage });
    @export(&bindings.getTransformFeedbackiv, .{ .name = "glGetTransformFeedbackiv", .linkage = linkage });
    @export(&bindings.getTransformFeedbacki_v, .{ .name = "glGetTransformFeedbacki_v", .linkage = linkage });
    @export(&bindings.getTransformFeedbacki64_v, .{ .name = "glGetTransformFeedbacki64_v", .linkage = linkage });
    @export(&bindings.createBuffers, .{ .name = "glCreateBuffers", .linkage = linkage });
    @export(&bindings.namedBufferStorage, .{ .name = "glNamedBufferStorage", .linkage = linkage });
    @export(&bindings.namedBufferData, .{ .name = "glNamedBufferData", .linkage = linkage });
    @export(&bindings.namedBufferSubData, .{ .name = "glNamedBufferSubData", .linkage = linkage });
    @export(&bindings.copyNamedBufferSubData, .{ .name = "glCopyNamedBufferSubData", .linkage = linkage });
    @export(&bindings.clearNamedBufferData, .{ .name = "glClearNamedBufferData", .linkage = linkage });
    @export(&bindings.clearNamedBufferSubData, .{ .name = "glClearNamedBufferSubData", .linkage = linkage });
    @export(&bindings.mapNamedBuffer, .{ .name = "glMapNamedBuffer", .linkage = linkage });
    @export(&bindings.mapNamedBufferRange, .{ .name = "glMapNamedBufferRange", .linkage = linkage });
    @export(&bindings.unmapNamedBuffer, .{ .name = "glUnmapNamedBuffer", .linkage = linkage });
    @export(&bindings.flushMappedNamedBufferRange, .{ .name = "glFlushMappedNamedBufferRange", .linkage = linkage });
    @export(&bindings.getNamedBufferParameteriv, .{ .name = "glGetNamedBufferParameteriv", .linkage = linkage });
    @export(&bindings.getNamedBufferParameteri64v, .{ .name = "glGetNamedBufferParameteri64v", .linkage = linkage });
    @export(&bindings.getNamedBufferPointerv, .{ .name = "glGetNamedBufferPointerv", .linkage = linkage });
    @export(&bindings.getNamedBufferSubData, .{ .name = "glGetNamedBufferSubData", .linkage = linkage });
    @export(&bindings.createFramebuffers, .{ .name = "glCreateFramebuffers", .linkage = linkage });
    @export(&bindings.namedFramebufferRenderbuffer, .{ .name = "glNamedFramebufferRenderbuffer", .linkage = linkage });
    @export(&bindings.namedFramebufferParameteri, .{ .name = "glNamedFramebufferParameteri", .linkage = linkage });
    @export(&bindings.namedFramebufferTexture, .{ .name = "glNamedFramebufferTexture", .linkage = linkage });
    @export(&bindings.namedFramebufferTextureLayer, .{ .name = "glNamedFramebufferTextureLayer", .linkage = linkage });
    @export(&bindings.namedFramebufferDrawBuffer, .{ .name = "glNamedFramebufferDrawBuffer", .linkage = linkage });
    @export(&bindings.namedFramebufferDrawBuffers, .{ .name = "glNamedFramebufferDrawBuffers", .linkage = linkage });
    @export(&bindings.namedFramebufferReadBuffer, .{ .name = "glNamedFramebufferReadBuffer", .linkage = linkage });
    @export(&bindings.invalidateNamedFramebufferData, .{ .name = "glInvalidateNamedFramebufferData", .linkage = linkage });
    @export(&bindings.invalidateNamedFramebufferSubData, .{ .name = "glInvalidateNamedFramebufferSubData", .linkage = linkage });
    @export(&bindings.clearNamedFramebufferiv, .{ .name = "glClearNamedFramebufferiv", .linkage = linkage });
    @export(&bindings.clearNamedFramebufferuiv, .{ .name = "glClearNamedFramebufferuiv", .linkage = linkage });
    @export(&bindings.clearNamedFramebufferfv, .{ .name = "glClearNamedFramebufferfv", .linkage = linkage });
    @export(&bindings.clearNamedFramebufferfi, .{ .name = "glClearNamedFramebufferfi", .linkage = linkage });
    @export(&bindings.blitNamedFramebuffer, .{ .name = "glBlitNamedFramebuffer", .linkage = linkage });
    @export(&bindings.checkNamedFramebufferStatus, .{ .name = "glCheckNamedFramebufferStatus", .linkage = linkage });
    @export(&bindings.getNamedFramebufferParameteriv, .{ .name = "glGetNamedFramebufferParameteriv", .linkage = linkage });
    @export(&bindings.getNamedFramebufferAttachmentParameteriv, .{ .name = "glGetNamedFramebufferAttachmentParameteriv", .linkage = linkage });
    @export(&bindings.createRenderbuffers, .{ .name = "glCreateRenderbuffers", .linkage = linkage });
    @export(&bindings.namedRenderbufferStorage, .{ .name = "glNamedRenderbufferStorage", .linkage = linkage });
    @export(&bindings.namedRenderbufferStorageMultisample, .{ .name = "glNamedRenderbufferStorageMultisample", .linkage = linkage });
    @export(&bindings.getNamedRenderbufferParameteriv, .{ .name = "glGetNamedRenderbufferParameteriv", .linkage = linkage });
    @export(&bindings.createTextures, .{ .name = "glCreateTextures", .linkage = linkage });
    @export(&bindings.textureBuffer, .{ .name = "glTextureBuffer", .linkage = linkage });
    @export(&bindings.textureBufferRange, .{ .name = "glTextureBufferRange", .linkage = linkage });
    @export(&bindings.textureStorage1D, .{ .name = "glTextureStorage1D", .linkage = linkage });
    @export(&bindings.textureStorage2D, .{ .name = "glTextureStorage2D", .linkage = linkage });
    @export(&bindings.textureStorage3D, .{ .name = "glTextureStorage3D", .linkage = linkage });
    @export(&bindings.textureStorage2DMultisample, .{ .name = "glTextureStorage2DMultisample", .linkage = linkage });
    @export(&bindings.textureStorage3DMultisample, .{ .name = "glTextureStorage3DMultisample", .linkage = linkage });
    @export(&bindings.textureSubImage1D, .{ .name = "glTextureSubImage1D", .linkage = linkage });
    @export(&bindings.textureSubImage2D, .{ .name = "glTextureSubImage2D", .linkage = linkage });
    @export(&bindings.textureSubImage3D, .{ .name = "glTextureSubImage3D", .linkage = linkage });
    @export(&bindings.compressedTextureSubImage1D, .{ .name = "glCompressedTextureSubImage1D", .linkage = linkage });
    @export(&bindings.compressedTextureSubImage2D, .{ .name = "glCompressedTextureSubImage2D", .linkage = linkage });
    @export(&bindings.compressedTextureSubImage3D, .{ .name = "glCompressedTextureSubImage3D", .linkage = linkage });
    @export(&bindings.copyTextureSubImage1D, .{ .name = "glCopyTextureSubImage1D", .linkage = linkage });
    @export(&bindings.copyTextureSubImage2D, .{ .name = "glCopyTextureSubImage2D", .linkage = linkage });
    @export(&bindings.copyTextureSubImage3D, .{ .name = "glCopyTextureSubImage3D", .linkage = linkage });
    @export(&bindings.textureParameterf, .{ .name = "glTextureParameterf", .linkage = linkage });
    @export(&bindings.textureParameterfv, .{ .name = "glTextureParameterfv", .linkage = linkage });
    @export(&bindings.textureParameteri, .{ .name = "glTextureParameteri", .linkage = linkage });
    @export(&bindings.textureParameterIiv, .{ .name = "glTextureParameterIiv", .linkage = linkage });
    @export(&bindings.textureParameterIuiv, .{ .name = "glTextureParameterIuiv", .linkage = linkage });
    @export(&bindings.textureParameteriv, .{ .name = "glTextureParameteriv", .linkage = linkage });
    @export(&bindings.generateTextureMipmap, .{ .name = "glGenerateTextureMipmap", .linkage = linkage });
    @export(&bindings.bindTextureUnit, .{ .name = "glBindTextureUnit", .linkage = linkage });
    @export(&bindings.getTextureImage, .{ .name = "glGetTextureImage", .linkage = linkage });
    @export(&bindings.getCompressedTextureImage, .{ .name = "glGetCompressedTextureImage", .linkage = linkage });
    @export(&bindings.getTextureLevelParameterfv, .{ .name = "glGetTextureLevelParameterfv", .linkage = linkage });
    @export(&bindings.getTextureLevelParameteriv, .{ .name = "glGetTextureLevelParameteriv", .linkage = linkage });
    @export(&bindings.getTextureParameterfv, .{ .name = "glGetTextureParameterfv", .linkage = linkage });
    @export(&bindings.getTextureParameterIiv, .{ .name = "glGetTextureParameterIiv", .linkage = linkage });
    @export(&bindings.getTextureParameterIuiv, .{ .name = "glGetTextureParameterIuiv", .linkage = linkage });
    @export(&bindings.getTextureParameteriv, .{ .name = "glGetTextureParameteriv", .linkage = linkage });
    @export(&bindings.createVertexArrays, .{ .name = "glCreateVertexArrays", .linkage = linkage });
    @export(&bindings.disableVertexArrayAttrib, .{ .name = "glDisableVertexArrayAttrib", .linkage = linkage });
    @export(&bindings.enableVertexArrayAttrib, .{ .name = "glEnableVertexArrayAttrib", .linkage = linkage });
    @export(&bindings.vertexArrayElementBuffer, .{ .name = "glVertexArrayElementBuffer", .linkage = linkage });
    @export(&bindings.vertexArrayVertexBuffer, .{ .name = "glVertexArrayVertexBuffer", .linkage = linkage });
    @export(&bindings.vertexArrayVertexBuffers, .{ .name = "glVertexArrayVertexBuffers", .linkage = linkage });
    @export(&bindings.vertexArrayAttribBinding, .{ .name = "glVertexArrayAttribBinding", .linkage = linkage });
    @export(&bindings.vertexArrayAttribFormat, .{ .name = "glVertexArrayAttribFormat", .linkage = linkage });
    @export(&bindings.vertexArrayAttribIFormat, .{ .name = "glVertexArrayAttribIFormat", .linkage = linkage });
    @export(&bindings.vertexArrayAttribLFormat, .{ .name = "glVertexArrayAttribLFormat", .linkage = linkage });
    @export(&bindings.vertexArrayBindingDivisor, .{ .name = "glVertexArrayBindingDivisor", .linkage = linkage });
    @export(&bindings.getVertexArrayiv, .{ .name = "glGetVertexArrayiv", .linkage = linkage });
    @export(&bindings.getVertexArrayIndexediv, .{ .name = "glGetVertexArrayIndexediv", .linkage = linkage });
    @export(&bindings.getVertexArrayIndexed64iv, .{ .name = "glGetVertexArrayIndexed64iv", .linkage = linkage });
    @export(&bindings.createSamplers, .{ .name = "glCreateSamplers", .linkage = linkage });
    @export(&bindings.createProgramPipelines, .{ .name = "glCreateProgramPipelines", .linkage = linkage });
    @export(&bindings.createQueries, .{ .name = "glCreateQueries", .linkage = linkage });
    @export(&bindings.getQueryBufferObjecti64v, .{ .name = "glGetQueryBufferObjecti64v", .linkage = linkage });
    @export(&bindings.getQueryBufferObjectiv, .{ .name = "glGetQueryBufferObjectiv", .linkage = linkage });
    @export(&bindings.getQueryBufferObjectui64v, .{ .name = "glGetQueryBufferObjectui64v", .linkage = linkage });
    @export(&bindings.getQueryBufferObjectuiv, .{ .name = "glGetQueryBufferObjectuiv", .linkage = linkage });
    @export(&bindings.memoryBarrierByRegion, .{ .name = "glMemoryBarrierByRegion", .linkage = linkage });
    @export(&bindings.getTextureSubImage, .{ .name = "glGetTextureSubImage", .linkage = linkage });
    @export(&bindings.getCompressedTextureSubImage, .{ .name = "glGetCompressedTextureSubImage", .linkage = linkage });
    @export(&bindings.getGraphicsResetStatus, .{ .name = "glGetGraphicsResetStatus", .linkage = linkage });
    @export(&bindings.getnCompressedTexImage, .{ .name = "glGetnCompressedTexImage", .linkage = linkage });
    @export(&bindings.getnTexImage, .{ .name = "glGetnTexImage", .linkage = linkage });
    @export(&bindings.getnUniformdv, .{ .name = "glGetnUniformdv", .linkage = linkage });
    @export(&bindings.getnUniformfv, .{ .name = "glGetnUniformfv", .linkage = linkage });
    @export(&bindings.getnUniformiv, .{ .name = "glGetnUniformiv", .linkage = linkage });
    @export(&bindings.getnUniformuiv, .{ .name = "glGetnUniformuiv", .linkage = linkage });
    @export(&bindings.readnPixels, .{ .name = "glReadnPixels", .linkage = linkage });
    @export(&bindings.textureBarrier, .{ .name = "glTextureBarrier", .linkage = linkage });
    //----------------------------------------------------------------------------------------------
    // OpenGL 4.6 (Core Profile)
    //----------------------------------------------------------------------------------------------
    @export(&bindings.multiDrawArraysIndirectCount, .{ .name = "glMultiDrawArraysIndirectCount", .linkage = linkage });
    @export(&bindings.multiDrawElementsIndirectCount, .{ .name = "glMultiDrawElementsIndirectCount", .linkage = linkage });
    @export(&bindings.polygonOffsetClamp, .{ .name = "glPolygonOffsetClamp", .linkage = linkage });
    @export(&bindings.specializeShader, .{ .name = "glSpecializeShader", .linkage = linkage });
}

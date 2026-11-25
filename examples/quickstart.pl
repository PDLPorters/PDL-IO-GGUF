# Copyright 2026 Google LLC
#
# Licensed under the the same terms as Perl itself (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

use strict;
use warnings;
use File::Temp qw(tempfile);
use PDL;
use PDL::IO::GGUF qw(rgguf wgguf gguf_header);

my (undef, $path) = tempfile('pdl_gguf_XXXXXX', SUFFIX => '.gguf', UNLINK => 1);

# 1. Write model tensors and GGUF v3 metadata
my $tensors = {
    'blk.0.attn_q.weight'  => float([[0.1, -0.2, 0.3], [0.4, 0.5, -0.6]]),
    'blk.0.attn_norm.bias' => float([0.01, 0.02, 0.03]),
};
my $meta = {
    'general.architecture' => 'llama',
    'general.name'         => 'tiny-demo',
    'llama.block_count'    => 1,
};

wgguf($path, $tensors, $meta);

# 2. Inspect header metadata and tensor directory without loading payloads
my $hdr = gguf_header($path);
print 'GGUF version: ', $hdr->{version}, "\n";
print 'Architecture: ', $hdr->{metadata}{'general.architecture'}, "\n";
for my $t (@{ $hdr->{tensors} }) {
    printf "Tensor %-24s dims=[%s] offset=%d\n",
        $t->{name}, join('x', @{ $t->{dims} }), $t->{offset};
}

# 3. Load tensors and metadata into PDL and compute diagnostics
my ($loaded, $loaded_meta) = rgguf($path);
my $w = $loaded->{'blk.0.attn_q.weight'};
printf "Loaded %s: shape=(%s), l2_norm=%.4f\n",
    $loaded_meta->{'general.name'},
    join(',', $w->dims),
    sqrt(($w * $w)->sum);

# PDL::IO::GGUF

Pure-Perl reader and writer for **GGUF v3** model weight files (used by `llama.cpp` and `ggml`) directly to and from [PDL](https://pdl.perl.org/) ndarrays.

## Quickstart

```perl
use strict;
use warnings;
use PDL;
use PDL::IO::GGUF qw(rgguf wgguf gguf_header);

# Write tensors and GGUF v3 metadata
wgguf('model.gguf', {
    'blk.0.attn_q.weight' => float([[1, 2], [3, 4]]),
}, {
    'general.architecture' => 'llama',
    'llama.block_count'    => 1,
});

# Inspect header without loading tensor payloads
my $hdr = gguf_header('model.gguf');
print 'Version: ', $hdr->{version}, ', Arch: ', $hdr->{metadata}{'general.architecture'}, "\n";

# Load tensors and metadata back into PDL
my ($tensors, $meta) = rgguf('model.gguf');
print $tensors->{'blk.0.attn_q.weight'}, "\n";
```

See [examples/quickstart.pl](examples/quickstart.pl) for a complete runnable tutorial, and run `perldoc PDL::IO::GGUF` for the full API reference and tutorial.

## Installation

```bash
perl Makefile.PL
make
make test
make install
```

## License

the same terms as Perl itself.

use strict;
use warnings;
use Test::More;
use File::Temp qw(tempfile);
use PDL::IO::GGUF qw(rgguf gguf_header);

subtest 'disconfirmation: missing file' => sub {
    my $ok = eval { rgguf('/nonexistent/file.gguf'); 1 };
    ok(!$ok, 'rgguf dies on missing file');
};

subtest 'disconfirmation: corrupt magic bytes' => sub {
    my ($fh, $fname) = tempfile(UNLINK => 1, SUFFIX => '.gguf');
    binmode($fh);
    print {$fh} 'NOPE' . ("\0" x 32);
    close($fh);

    my $ok = eval { gguf_header($fname); 1 };
    ok(!$ok, 'gguf_header rejects invalid magic bytes');
};

done_testing();

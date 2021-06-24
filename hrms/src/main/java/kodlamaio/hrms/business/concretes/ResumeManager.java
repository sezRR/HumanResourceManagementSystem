package kodlamaio.hrms.business.concretes;

import kodlamaio.hrms.business.abstracts.ResumeService;
import kodlamaio.hrms.core.adapters.cloudinary.CloudinaryService;
import kodlamaio.hrms.core.utilities.converter.DtoConverterService;
import kodlamaio.hrms.core.utilities.results.*;
import kodlamaio.hrms.dataAccess.abstracts.ResumeDao;
import kodlamaio.hrms.entities.concretes.Resume;
import kodlamaio.hrms.entities.dtos.ResumeAddDto;
import kodlamaio.hrms.entities.dtos.ResumeUpdateDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@Service
public class ResumeManager implements ResumeService{
    private final ResumeDao resumeDao;
    private final CloudinaryService cloudinaryService;
    private final DtoConverterService dtoConverterService;

    @Autowired
    public ResumeManager(ResumeDao resumeDao, CloudinaryService cloudinaryService, DtoConverterService dtoConverterService) {
        this.resumeDao = resumeDao;
        this.cloudinaryService = cloudinaryService;
        this.dtoConverterService = dtoConverterService;
    }

    @Override
    public DataResult<List<Resume>> getAll() {
        return new SuccessDataResult<>(this.resumeDao.findAll());
    }

    @Override
    public Result add(ResumeAddDto resumeAddDto) {
        this.resumeDao.save((Resume)this.dtoConverterService.dtoToBaseClassConverter(resumeAddDto, Resume.class));
        return new SuccessResult("Added");
    }

    @Override
    public Result update(ResumeUpdateDto resumeUpdateDto) {
        Resume tempResume = this.resumeDao.getOne(resumeUpdateDto.getId());
        tempResume.setGithubLink(resumeUpdateDto.getGithubLink());
        tempResume.setLinkedLink(resumeUpdateDto.getLinkedinLink());
        tempResume.setPhoto(resumeUpdateDto.getPhoto());
        tempResume.setDescription(resumeUpdateDto.getDescription());
        this.updateUpdatedDate(resumeUpdateDto.getId());

        this.resumeDao.save(tempResume);

        return new SuccessResult("Updated");
    }

    @Override
    public Result updateUpdatedDate(int resumeId) {
        Resume tempResume = this.resumeDao.getOne(resumeId);
        tempResume.setUpdatedDate(LocalDate.now());
        this.resumeDao.save(tempResume);

        return new SuccessResult("Updated");
    }

    @Override
    public Result uploadImage(MultipartFile multipartFile, int resumeId) {
        try {
            String filePath = this.cloudinaryService.upload(multipartFile).getData().get("url").toString();

            Resume tempResume = resumeDao.getOne(resumeId);
            tempResume.setPhoto(filePath);
            resumeDao.save(tempResume);

            return new SuccessResult("Uploaded");
        } catch (IOException e) {
            return new ErrorResult("Exception: " + e.getMessage());
        }
    }
}
